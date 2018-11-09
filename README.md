 
# Commandline based automated file uploader for Windows File Explorer
Developed using AutoIT. This can be used to detect an open windows file explorer and executes the selecting of file and upload.
* Useful for automated testing of web based applications that has file uploading
* Can only run on Windows based systems
* Fully tested only on Win10


NOTE: This can only be run on Windows based machines. If you are looking for similar solutions for Mac or Linux, the closest solution I have come up with is using the Java based Sikulix tool. I am planning on writing an open sourced project on that if I have some time.
However, in terms of robustness for automation, this is much more reliable than Sikulix.

# Setup or Installation
1) Download the latest executable from the bin folder
2) Verify you can execute the .exe file (you should see something like)
  ```
   ps> AutomatedFileUploader.exe -h
   
   Windows Auto File Uploader
   Parameters: (\*) required   
       -d, directory path of files (\*)  
       -f, list of files to upload, space separated (\*)  
       -h, show help
   Ex:   
       ps>  AutoFileUploader.exe -d D:\Users\ibarraa\Documents -f fname1.txt fname2.txt
  ```
3) Open a windows file explorer and execute the .exe file

# How to use in your Ruby code:
If you are trying to automate file uploads for your web based application, and using something like RSpec and Capybara, you can automate file uploads by callng this as a System call.
```ruby
  automation_workingdir = File.dirname(__FILE__) + "/../loc_of_executable"
  cmd_call = AutomatedFileUploader.exe + "-d C:/Users/ibarraa/Documents/samples " + "-f file1.txt file2.jpg"
  Dir.chdir(automation_workingdir) do
    puts "EXECUTING SYSTEM CALL: #{cmd_call} \n\n"
    system(cmd_call)
  end
  ```

