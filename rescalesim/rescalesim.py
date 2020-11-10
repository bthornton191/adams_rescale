import os
import requests

URL = 'https://platform.rescale.com/api/v2/'

ADAMS_CODE = 'msc_adams'

# TODO: Figure out how to use the api to query for cores-per-slot instead of hard coding it here
CORES_PER_SLOT = {
    'onyx': 18,
    'amber': 60
}

class Session():
    def __init__(self, api_token, licensing):
        self.api_token = api_token
        self.licensing = licensing
        
    def download_file(self, file_id : str, dst : str):
        response = requests.get(URL + f'files/{file_id}/', headers={'Authorization': f'Token {self.api_token}'})        
        
        with open(dst, 'wb') as fd:
            for chunk in response.iter_content():
                fd.write(chunk)

        return

    def list_job_results_files(self, job_id : str) -> list:           
        response = requests.get(URL + f'jobs/{job_id}/files', headers={'Authorization': f'Token {self.api_token}'})        
        files = [{file['name']: file['id']} for file in response.json()['results']]
        return files

    def list_job_results(self, job_id : str) -> list:        
        response = requests.get(URL + f'jobs/{job_id}/runs', headers={'Authorization': f'Token {self.api_token}'})
        return response.json()['results']

    def get_job_status(self, job_id : str) -> list:        
        response = requests.get(URL + f'jobs/{job_id}/statuses/', headers={'Content-Type': 'application/json', 'Authorization': f'Token {self.api_token}'}) 
        return response.json()['results']

    def get_job_details(self, job_id : str) -> dict:    
        response = requests.get(URL + f'jobs/{job_id}/', headers={'Authorization': f'Token {self.api_token}'}) 
        return response.json()

    def submit_job(self, job_id : str) -> str:
        """Submits a previously created job

        Parameters
        ----------
        job_id : str
            Job id

        Returns
        -------
        dict
            Server Response

        """
        response = requests.post(URL + f'jobs/{job_id}/submit/', headers={'Content-Type': 'application/json', 'Authorization': f'Token {self.api_token}'})
        return response.status_code==200

    def create_adams_solver_job(self, name : str, acf_file : str, adm_file : str, version=None, core_type='ferrite', n_cores=1) -> str :
        """Creates an Adams Solver Job

        Parameters
        ----------
        name : str
            Job Name
        acf_file : str
            Local path to acf file
        adm_file : str
            Local path to adm file
        version : str, optional
            version code indicating which version of Adams Solver to use, by default latest version
        core_type : str, optional
            Core type code indicating which type of hardware to use, by default cheapest option
        n_cores : int, optional
            Number of cores to use.  Must match the number of processors specified in the adm file, by default 1

        Returns
        -------
        str
            Job id

        """
        acf_name = os.path.split(acf_file)[-1]
        command = f'run-adams -f {acf_name}'
        analysis = {
            'code': ADAMS_CODE,
            'version': self.get_latest_software_version(ADAMS_CODE) if version is None else version
        }

        hardware = {
            'coreType': self.get_cheapest_core() if core_type is None else core_type,
            'coresPerSlot': n_cores,
            'cores': n_cores
        }

        input_files = [
            {'id': self.upload_file(acf_file, 1)},
            {'id': self.upload_file(adm_file, 1)}
        ]

        licensing = {
            'useRescaleLicense': self.licensing['useRescaleLicense'],
            'userDefinedLicenseSettings': self.licensing['userDefinedLicenseSettings']
        }

        data={
            'name': name,
            'jobanalyses': [
                {'analysis': analysis, 'command': command, 'hardware': hardware, 'inputFiles': input_files, **licensing}
            ]
        }

        response = requests.post(URL + 'jobs/', headers={'Content-Type': 'application/json', 'Authorization': f'Token {self.api_token}'}, json=data)        
        job_id = response.json()['id']

        return job_id

    def list_analyses(self):
        response = requests.get(URL + 'analyses/', headers={'Authorization': f'Token {self.api_token}'})
        return response.json()['results']

    def get_latest_software_version(self, software_code : str):
        analyses = self.list_analyses()
        software = [sw for sw in analyses if sw['code'] == software_code][0]
        
        return software['versions'][0]['versionCode']

    def get_core_types(self):
        response = requests.get(URL + 'coretypes/', headers={'Authorization': f'Token {self.api_token}'})
        return response.json()['results']

    def get_cheapest_core(self):
        core_types = self.get_core_types()
        core_prices = {core_type['code']: float(core_type['price']) for core_type in core_types}
        core_prices_sorted = {core: price for core, price in sorted(core_prices.items(), key=lambda item: item[1])}

        return [k for k in core_prices_sorted.keys()][0]


    def upload_file(self, filename : str, type_id : int):
        """Upload a file to rescale

        Parameters
        ----------
        filename : str
            Local name of file
        type_id : int
            Type id of file. 1 = inpute file, 2 = template file, 3 = parameter file, 4 = script file, 5 = output file, 7 = design variable file, 8 = case file, 9 = optimizer file, 10 = temporary file

        Returns
        -------
        str
            File id

        """
        new_name = os.path.split(filename)[-1]
        # with open(filename, 'rb') as fid:

        # response = requests.post(URL + 'files/contents/', headers={'Content-Type': 'multipart/form-data', 'Authorization': f'Token {self.api_token}'}, files={'file': (new_name, open(filename, 'r'), {'type_id': type_id})})
        response = requests.post(URL + 'files/contents/', headers={'Authorization': f'Token {self.api_token}'}, files={'file': (new_name, open(filename, 'r'), {'type_id': type_id})})
        file_id = response.json()['id']
        return file_id
