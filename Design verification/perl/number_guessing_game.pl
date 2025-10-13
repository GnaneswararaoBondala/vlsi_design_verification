use strict;
use warnings;
use feature "say";

my $secret=int(rand(10))+1;
my $guess;

print"Guess the number between 1 and 10\n";

while(1){
    print "Enter your guess:";
    $guess=<STDIN>;
    chomp($guess);

    if($guess==$secret){
        print "Congratulations !you have guessed it right\n";
        last;

    }
    elsif($guess>$secret){
        print "Too low!Try again";
    }
    else{
        print "Too high !try again.\n";
    }
}