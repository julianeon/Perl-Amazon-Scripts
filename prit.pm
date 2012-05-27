package Prit;

use strict;
use Exporter;
use vars qw(@ISA @EXPORT_OK);

@ISA=qw(Exporter);
@EXPORT_OK=qw(prin prins printfs printfa printfad printfam prina prindot);

sub prindot
{
	print "********************************************************JULIAN*MARTINEZ**********************************************\n";
}

sub prin
{
	my $var=$_[0];
	print $var,"\n";
}

sub prins
{
	my $var=$_[0];
	print $var," ";
}

sub printfs
{
	my $file=$_[0];
	my $str=$_[1];
	open(my $fh,">",$file);
	print $fh $str;
	close($fh);
}

sub printfa
{
	my $file=$_[0];
	my @array=@{$_[1]};
	open(my $fh,">",$file);
	foreach(@array){
		print $fh $_;
		print $fh "\n";
	}
	close($fh);
}

sub printfam
{
	my $file=$_[0];
	my @array=@{$_[1]};
	my @arrprint;
	foreach my $line (@array){
        	my $cmd;
        	foreach (@{$line}){
                	$cmd.=$_;
                	$cmd.=",";
        	}
        push(@arrprint,$cmd);
	}
	printfa($file,\@arrprint);
}


sub printfad
{
	my $file=$_[0];
	my @array=@{$_[1]};
	open(my $fh,">>",$file);
	foreach(@array){
		print $fh $_;
		print $fh "\n";
	}
	close($fh);
}

sub prina
{
	my @arr=@{$_[0]};
	foreach (@arr){
		print $_,"\n";
	}
}

1;
