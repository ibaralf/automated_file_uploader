 
# Commandline based automated file uploader for Windows File Explorer
Developed using AutoIT. This can be used to detect an open windows file explorer and executes the selecting of file and upload.
* Useful for automated testing of web based applications that has file uploading
* Can only run on Windows based systems
* Fully tested only on Win10


NOTE: This can only be run on Windows based machines. If you are looking for similar solutions for Mac or Linux, the closest solution I have come up with is using the Java based [Sikulix tool](http://sikulix.com/). I am planning on writing an open sourced project on that if I have some time.

However, in terms of robustness for automation, this is much more reliable than Sikulix.

# Setup or Installation
1) Download the latest executable from the [bin](https://github.com/ibaralf/automated_file_uploader/tree/master/bin) folder
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

# How it Works
1) From your application, open a file upload window (ex. your web based application having an upload link that you click)
2) Browsers that allows file uploads usually opens the local file system GUI
3) Execute AutomatedFileUploader.exe with the right parameters
4) Files are then automatically uploaded

# Using in Ruby code:
If you are trying to automate file uploads for your web based application, and using something like RSpec and Capybara, you can automate file uploads by callng this as a System call.
```ruby
  automation_workingdir = File.dirname(__FILE__) + "/../loc_of_executable"
  cmd_call = AutomatedFileUploader.exe + "-d C:/Users/ibarraa/Documents/samples " + "-f file1.txt file2.jpg"
  Dir.chdir(automation_workingdir) do
    puts "EXECUTING SYSTEM CALL: #{cmd_call} \n\n"
    system(cmd_call)
  end
  ```
# Using in Java:
```java
   Runtime.getRuntime().exec("C:\\Users\\ibarraa\\AutomatedFileUploader.exe");
```
# Using in Python code:
Please add Here

# NOTES:
* You can add support or fixes by opening PRs
* Support for other Windows version would be appreciated
* Spaces in file names still not currently supported.

# License
This tool is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). 
