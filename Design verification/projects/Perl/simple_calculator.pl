use strict;
use warnings;

while(1){
    print "Enter first number (or 'exit' to quit):";
    my $num1=<STDIN>;
    chomp($num1);
    last if $num1 eq "exit";

    print "Enter operator (+,-,*,/):";
    my $operator=<STDIN>;
    chomp($operator);

    print "Enter second number:";
    my $num2=<STDIN>;
    chomp($num2);

    my $result;
    if($operator eq "+"){
        $result=$num1+$num2;
    }
    elsif($operator eq "-"){
        $result=$num1-$num2;
    }
    elsif($operator eq "*"){
        $result=$num1*$num2;
    }
    elsif($operator eq "/"){
        $result=$num2!=0?$num1 /$num2:"Error:Divison by zero";

    }
    else{
        print "Invalid operator!\n";
        next;
    }

    print "Result:$result\n";


}