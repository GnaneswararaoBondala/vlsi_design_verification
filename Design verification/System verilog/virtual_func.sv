class animal;
function void speak();
$display("Animal makes a sound");
endfunction 
endclass

class dog extends animal;
function void speak();
$display("Dog barks");
endfunction
endclass

class cat extends animal;
function void speak();
$display("Cat meows");
endfunction
endclass

module inher_poly_example;
initial begin
animal animal_h;
dog dog_h;
cat cat_h;

animal_h=new();
dog_h=new();
cat_h=new();

animal_h=dog_h;
animal_h.speak();
end
endmodule
