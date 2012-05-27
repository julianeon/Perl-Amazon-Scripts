package Az;

use strict;
use Exporter;
use vars qw(@ISA @EXPORT_OK);
use Cot qw(load);

@ISA=qw(Exporter);
@EXPORT_OK=qw(Ser Iaz respstr respinit detitle princo orz ort giftcard changename);

sub changename
{
        my ($val,$file,$word,$maybe)=@_;
        if ($val==0){
                my $line=$word;
                $line.=$file;
                return $line;
        }
        elsif ($val==1){
                my $line=$file;
                $word.=".txt";
                $line=~s/\.txt/$word/g;
                return $line;
        }
        elsif ($val==2){
                my $line=$file;
                $line=~s/$word/$maybe/g;
                return $line;
        }
}

sub Ser
{
	my $var=$_[0];
	my $file="Ser/file";
	$file.=$var;
	$file.=".txt";
}

sub Iaz{
	my $var=$_[0];
	if ($var){
        Net::Amazon->new(
                token      => 'dummy_value_1',
                secret_key => 'dummy_value_2',
                associate_tag=>'dummy_value_3',
                max_pages  => $var,);
	}
	else{
        Net::Amazon->new(
                token      => 'dummy_value_1',
                secret_key => 'dummy_value_2',
                associate_tag=>'dummy_value_3',);
	}

}

sub respstr
{
	my $resp=$_[0];

	open(my $fh,">",$_[1]);

 	if ($resp->is_success()) {
        	print $fh $resp->as_string, "\n";
	}	
	else {
        	print $resp->message(), "\n";
	}

	close($fh);
}

sub respinit
{
	my $resp=$_[0];

	my $file=$_[1];

	open(my $fh,">",$file);
	$file=~s/.txt/price.txt/;
	open(my $gh,">",$file);

	foreach ($resp->properties){
        	my $val= $_->ASIN();
        	print $fh "$val\n";
        	my $price= $_->UsedPrice();
		$price=~s/\$//;
		$price+=0;
        	print $gh "$price\n";
		print "serial $val price $price\n";
	}
	close($fh);
	close($gh);
	return $file;
}

sub detitle
{
	my $var=$_[0];
	my @row=split(":",$var);
	@row=split(",",$row[0]);
	$row[0]=~s/'//g;
	$row[0]=~s/and//g;
	$row[0]=~s/&//g;
	$row[0]=~s/\ \ /\ /g;
	return $row[0];
}

sub princo
{
	my $var=$_[0];
	$var.=",";
	return $var;
}

sub orz
{
	my $var=$_[0];
	$var=~s/\$//g;
	my $num=0;
	$num+=$var;
	return $num;
}

sub ort
{
	my $var=$_[0];
	my $text="Book";
	if ($var){
		return $var;
	}
	else{
	return $text;
	}
}

sub giftcard
{
my $fh=$_[0];
my @lines=load($fh);

foreach (@lines){
        my @row=split("\ ",$_);
        my $size=scalar(@row);
        for (my $i=0;$i<$size;$i++){
                if ($row[$i]=~m/Copy/){
                        if ($row[$i+1]=~m/For/){
                                if ($row[$i+3]=~m/\$/){
                                        my $var=$row[$i+3];
                                        $var=~s/\$//g;
                                        return $var;
                                }
                        }
                }
        }
}

return 0;
}

1;

