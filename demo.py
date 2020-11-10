import os
import time
import json

from rescalesim.rescalesim import Session

# Get the authorization token key
with open('config.json') as fid:
    config = json.load(fid)

acf_file = os.path.join('rescale_analysis.acf')
adm_file = os.path.join('rescale_analysis.adm')

# Create a rescale session
session = Session(config['api_token'], config['licensing'])

job_results = session.get_job_details('CjmxEc')
core_types = session.get_core_types()

# job_id = 'xbMTEc'
# Create the job
job_id = session.create_adams_solver_job('api_test_job', acf_file=acf_file, adm_file=adm_file)

# Submit the job
response = session.submit_job(job_id)

# Monitor job status
while True:
    status = session.get_job_status(job_id)[0]['status'] 
    print(status)
    if status == 'Completed':
        break
    time.sleep(5)

# List the results
results = session.list_job_results(job_id)

# Download the results files
os.makedirs(os.path.join('downloaded_results', job_id))
for file in session.list_job_results_files(job_id):
    (filename, file_id) = [(k, v) for k,v in file.items()][0]
    dst = os.path.join('downloaded_results', job_id, filename)
    session.download_file(file_id, dst)