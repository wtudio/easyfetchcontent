import TestPybind11

print(TestPybind11.add(1, 2))

#########

def python_function(x):
    return "Received: " + str(x)

TestPybind11.call_function(python_function)

#########

my_obj = TestPybind11.TestClass()
print(my_obj.getName())
my_obj.setName("Hello world")
print(my_obj.getName())
