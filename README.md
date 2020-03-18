# EEC-201-Final-Project
This project includes Project_Report.pdf
and all running codes and simple GUI

1. To open GUI, open 'Project_New/GUI/interface.m'
2. to test on noise analysis.
   in matlab command window.
   type 
   codebooks = train('D:\MATLAB\EEC201\project_new\training data',11);
   and
   test('D:\MATLAB\EEC201\project_new\training data',11,codebooks,noise_level);
   
   Note: the first entry of train and test function are dir of testing data and training data stored on the computer. 
         argument :noise_level is the noise level (a number between 0 and 1) you want to add to the voice signal.
         for more information, please check the report.
