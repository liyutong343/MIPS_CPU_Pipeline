file1 = open('C:\\Users\\liyutong\\Desktop\\code.txt', 'r')
asmCode = file1.read()
file1.close()

asmCode = asmCode.split("\n")

file2 = open('C:\\Users\\liyutong\\Desktop\\code_for_vivado.txt', 'w')
i = 0
for code in asmCode:
    print(file2.write("8'd" + str(i) + ": Instruction <= 32'h" + code + ';\n'))
    i = i + 1

# file2 = open('C:\\Users\\liyutong\\Desktop\\code_for_vivado.txt', 'w')
# i = 0
# for code in asmCode:
#     print(file2.write("data[9'd" + str(i) + "] <= 32'h" + code + ';\n'))
#     i = i + 1