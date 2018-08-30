require 'fileutils'
require 'open3'

file1 = ARGV[0]
file2 = ARGV[1]

code_file_ext = File.extname(file1)
code_file_name = File.basename(file1, ".*")
code_file_dir = File.dirname(file1)
code_file_output = code_file_dir + code_file_name + "_output.txt"

# puts compare_result
stdout, stderr, status = Open3.capture3("gcc #{file1}")
if stderr.empty?
	stdout, stderr, status = Open3.capture3("./a.out")
end

if stderr.empty?
	f= open(code_file_output,"w+")
	f.write(stdout)
	f.close

	compare_result = FileUtils.compare_file(file2, code_file_output)

	if compare_result
		puts("Correct output!!!")
	else
		puts("Wrong Answer!!!")
	end
else
	puts(stderr)
end


