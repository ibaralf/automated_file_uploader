 
# Commandline based automated file uploader for Windows File Explorer
Developed using AutoIT. This can be used to detect an open windows file explorer and executes the selecting of file and upload.
* Useful for automated testing of web based applications that has file uploading
* Can only run on Windows based systems
* Fully tested only on Win10


NOTE: This can only be run on Windows based machines. If you are looking for similar solutions for Mac or Linux, the closest solution I have come up with is using the Java based [Sikulix tool](http://sikulix.com/). I am planning on writing an open sourced project on that if I have some time.

However, in terms of robustness for automation, this is much more reliable than Sikulix.

# Setup or Installation
Simply download the correct executable, either the 32 or 64 bit version.

To test it manually:
1) Download the latest executable from the [bin](https://github.com/ibaralf/automated_file_uploader/tree/master/bin) folder, there are two versions (32 and 64).
2) Open a powershell window
3) Change to the directory where you downloaded the exe file
4) Execute the .exe file as shown below, you should see the help menu
  ```
   ps> AutomatedFileUploader32.exe -h | more
   
   Windows Auto File Uploader
   Parameters:  (*) required
     -d, directory path of files (*)
     -f, list of files to upload, space separated (*)
     -h, show help
   Ex:
     ps>  AutoFileUploader.exe -d D:\Users\ibarraa\Documents -f fname1.txt fname2.txt
  ```
Note: You need the (| more) to be able to show the output to the command line shell.

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

# ISSUES and TODOs
* Output to console (commandline) does not show (workaround is to use pipe more - '| more')
* Clean up lots of debugging messages
* Implement log to file in logger.au3
* Optimize and remove unnecessary checking of handler for window or control
* Verify on other Windows platform


# NOTES:
* You can add support or fixes by opening PRs
* Support for other Windows version would be appreciated
* Spaces in file names still not currently supported.

# License
This tool is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). 
