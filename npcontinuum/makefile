# 定义编译器和链接器
FC = gfortran
LD = $(FC)

# 定义编译选项
F90FLAGS = -Wall -Wextra
LDFLAGS =  

# 定义目标文件
TARGET = npcontinuum
# 定义源文件
SOURCES = npcontinuum.f  module.f  function.f coulfunc.f parameter.f
# 将源文件转换为对象文件
OBJECTS = $(SOURCES:.f=.o)
# 定义需要链接的库
LIBS =  

# 默认目标
all: $(TARGET)

# 生成可执行文件
$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $(TARGET)

# 生成对象文件
%.o: %.f
	$(FC) $(FFLAGS) -c $< -o $@

# 清理中间文件和可执行文件
clean:
	rm -f $(OBJECTS) $(TARGET)