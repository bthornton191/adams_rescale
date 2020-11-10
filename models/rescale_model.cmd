!
!-------------------------- Default Units for Model ---------------------------!
!
!
defaults units  &
   length = inch  &
   angle = deg  &
   force = pound_force  &
   mass = pound_mass  &
   time = sec
!
defaults units  &
   coordinate_system_type = cartesian  &
   orientation_type = body313
!
!------------------------ Default Attributes for Model ------------------------!
!
!
defaults attributes  &
   inheritance = bottom_up  &
   icon_visibility = on  &
   grid_visibility = off  &
   size_of_icons = 7.874E-02  &
   spacing_for_grid = 39.3700787402
!
!------------------------------ Adams View Model ------------------------------!
!
!
model create  &
   model_name = rescale_model
!
view erase
!
!--------------------------------- Materials ----------------------------------!
!
!
material create  &
   material_name = .rescale_model.steel  &
   adams_id = 1  &
   density = 0.2818290049  &
   youngs_modulus = 3.002281171E+07  &
   poissons_ratio = 0.29
!
!-------------------------------- Rigid Parts ---------------------------------!
!
! Create parts and their dependent markers and graphics
!
!----------------------------------- ground -----------------------------------!
!
!
! ****** Ground Part ******
!
defaults model  &
   part_name = ground
!
defaults coordinate_system  &
   default_coordinate_system = .rescale_model.ground
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .rescale_model.ground.MARKER_4  &
   adams_id = 4  &
   location = 0.0, 12.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
!----------------------------------- PART_2 -----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .rescale_model.ground
!
part create rigid_body name_and_position  &
   part_name = .rescale_model.PART_2  &
   adams_id = 2  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .rescale_model.PART_2
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .rescale_model.PART_2.MARKER_1  &
   adams_id = 1  &
   location = 0.0, 12.0, 0.0  &
   orientation = 24.7751405688d, 90.0d, 0.0d
!
marker create  &
   marker_name = .rescale_model.PART_2.cm  &
   adams_id = 7  &
   location = 3.0, 5.5, 0.0  &
   orientation = 24.7751405688d, 90.0d, 0.0d
!
marker create  &
   marker_name = .rescale_model.PART_2.MARKER_3  &
   adams_id = 3  &
   location = 0.0, 12.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .rescale_model.PART_2.MARKER_6  &
   adams_id = 6  &
   location = 6.0, -1.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .rescale_model.PART_2  &
   material_type = .rescale_model.steel
!
! ****** Graphics for current part ******
!
geometry create shape cylinder  &
   cylinder_name = .rescale_model.PART_2.CYLINDER_1  &
   adams_id = 1  &
   center_marker = .rescale_model.PART_2.MARKER_1  &
   angle_extent = 360.0  &
   length = 14.3178210633  &
   radius = 1.7897276329  &
   side_count_for_body = 20  &
   segment_count_for_ends = 20
!
part attributes  &
   part_name = .rescale_model.PART_2  &
   color = RED  &
   name_visibility = off
!
!----------------------------------- PART_3 -----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .rescale_model.ground
!
part create rigid_body name_and_position  &
   part_name = .rescale_model.PART_3  &
   adams_id = 3  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .rescale_model.PART_3
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .rescale_model.PART_3.MARKER_2  &
   adams_id = 2  &
   location = 6.0, -1.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .rescale_model.PART_3.cm  &
   adams_id = 8  &
   location = 6.0, -1.0, 0.0  &
   orientation = 180.0d, 90.0d, 90.0d
!
marker create  &
   marker_name = .rescale_model.PART_3.MARKER_5  &
   adams_id = 5  &
   location = 6.0, -1.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .rescale_model.PART_3  &
   material_type = .rescale_model.steel
!
! ****** Graphics for current part ******
!
geometry create shape ellipsoid  &
   ellipsoid_name = .rescale_model.PART_3.ELLIPSOID_2  &
   adams_id = 2  &
   center_marker = .rescale_model.PART_3.MARKER_2  &
   x_scale_factor = 5.6568542494  &
   y_scale_factor = 5.6568542494  &
   z_scale_factor = 5.6568542494
!
part attributes  &
   part_name = .rescale_model.PART_3  &
   color = GREEN  &
   name_visibility = off
!
!----------------------------------- Joints -----------------------------------!
!
!
constraint create joint revolute  &
   joint_name = .rescale_model.JOINT_1  &
   adams_id = 1  &
   i_marker_name = .rescale_model.PART_2.MARKER_3  &
   j_marker_name = .rescale_model.ground.MARKER_4
!
constraint attributes  &
   constraint_name = .rescale_model.JOINT_1  &
   name_visibility = off
!
constraint create joint fixed  &
   joint_name = .rescale_model.JOINT_2  &
   adams_id = 2  &
   i_marker_name = .rescale_model.PART_3.MARKER_5  &
   j_marker_name = .rescale_model.PART_2.MARKER_6
!
constraint attributes  &
   constraint_name = .rescale_model.JOINT_2  &
   name_visibility = off
!
!----------------------------------- Forces -----------------------------------!
!
!
!----------------------------- Simulation Scripts -----------------------------!
!
!
simulation script create  &
   sim_script_name = .rescale_model.Last_Sim  &
   commands =   &
              "simulation single_run scripted sim_script_name=.rescale_model.SIM_SCRIPT_1 reset_before_and_after=yes model_name=.rescale_model"
!
simulation script create  &
   sim_script_name = .rescale_model.SIM_SCRIPT_1  &
   solver_commands = "! Insert ACF commands here:", "SIMULATE/STATIC",  &
                     "SIMULATE/DYNAMIC, END=5.0, DTOUT=1.0E-02"
!
!---------------------------------- Accgrav -----------------------------------!
!
!
force create body gravitational  &
   gravity_field_name = ACCGRAV_1  &
   x_component_gravity = 0.0  &
   y_component_gravity = -386.0885826772  &
   z_component_gravity = 0.0
!
force attributes  &
   force_name = .rescale_model.ACCGRAV_1  &
   active = on
!
!----------------------------- Analysis settings ------------------------------!
!
!
!--------------------------- Expression definitions ---------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = ground
!
geometry modify shape cylinder  &
   cylinder_name = .rescale_model.PART_2.CYLINDER_1  &
   length = (14.3178210633inch)  &
   radius = (1.7897276329inch)
!
geometry modify shape ellipsoid  &
   ellipsoid_name = .rescale_model.PART_3.ELLIPSOID_2  &
   x_scale_factor = (2 * 2.8284271247inch)  &
   y_scale_factor = (2 * 2.8284271247inch)  &
   z_scale_factor = (2 * 2.8284271247inch)
!
material modify  &
   material_name = .rescale_model.steel  &
   density = (7801.0(kg/meter**3))  &
   youngs_modulus = (2.07E+11(Newton/meter**2))
!
model display  &
   model_name = rescale_model
