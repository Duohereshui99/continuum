# 定义编译器和链接器
FC = gfortran
LD = $(FC)

# 定义编译选项
FFLAGS = -O3 -Wall -Wextra -ffixed-line-length-0 -cpp -g
LDFLAGS =  

# 定义目标文件
TARGET = npcontinuum
# 定义源文件
SOURCES = parameter.f  module.f variable.f function.f coulfunc.f npcontinuum.f 
# 将源文件转换为对象文件
OBJECTS = $(SOURCES:.f=.o)
# 定义需要链接的库
LIBS =  -llapack

# 默认目标
all: $(TARGET)

# 生成对象文件
%.o: %.f
	$(FC) $(FFLAGS) -c $< -o $@

# 生成可执行文件
$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $(TARGET) $(LIBS)

# 清理中间文件和可执行文件
clean:
	rm -f $(OBJECTS) $(TARGET) *.mod fort.*
