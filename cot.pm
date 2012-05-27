package Cot;

use strict;
use Exporter;
use vars qw(@ISA @EXPORT_OK);
use DateTime;
use Prit qw(printfa prina prin);
use POSIX;
use Math::Round;

@ISA=qw(Exporter);
@EXPORT_OK=qw(splitload csvcomma load perlrun catfile csver minuto timemark wurd cut ofwhole says daymark);

sub splitload
{
	my @serial=@{$_[0]};
	my $ct=0;
	my @ak;
	foreach (@serial){
        	my @row=split(",",$_);
        	foreach (@row){
        		push @{$ak[$ct]},$_;
        	}
        $ct++;
	}
	return @ak;
}

sub csvcomma
{
	my $cmd;
	foreach (@_){
		$cmd.=$_;
		$cmd.=",";
	}
	return $cmd;
}

sub ofwhole
{
	my $i=$_[0];
	my $size=$_[1];
	if ($size==0){return 100};
	my $ratio=nearest(.1,(($i/$size)*100));
	return $ratio;
}

sub cut
{
	my $from=$_[0];
	my $num=$_[1];
	my @lines=load($from);
	for (my $i=0;$i<$num;$i++){
		pop(@lines);
	}
	printfa($from,\@lines);

}

sub load
{
	my $var=$_[0];
	open (FILE,"<",$var);
	my @lines=<FILE>;
	close(FILE);
	chomp(@lines);
	return @lines;
}

sub perlrun
{
	my $cmd="perl ";
	foreach (@_){
		$cmd=join("",$cmd,$_);
		$cmd=join("",$cmd," ");
	}
	system($cmd);

}

sub catfile
{
	my $from=$_[0];
	my $to=$_[1];
	my $cmd="cat ";
	$cmd.=$from;
	$cmd.=" >> ";
	$cmd.=$to;
	system($cmd);
}

sub csver
{
	my $num=$_[0];
	my $file=$_[1];
	my @array=load($file);
	my @pos;
	foreach(@array){
		my @row=split(",",$_);
		push(@pos,$row[$num]);
	}
	return @pos;
}

sub minuto
{	
	my $val=$_[0];
	for (my $i=0;$i<$val;$i++){
		my $time=$i+1;
		print "minute $time\n";
		system("sleep 60");
	}
}

sub timemark
{
	my $dt=DateTime->now(time_zone=>'local');
        my $hourmin=substr($dt->hms,0,5);
	my @num=split(":",$hourmin);
	if ($num[0]>12) {$num[0]-=12;}
	my $time=join("",$num[0],":",$num[1]);
}

sub daymark
{
        my $dt=DateTime->now(time_zone=>'local');
        my $day=$dt->day;
        my $month=$dt->month;
        my $yr=substr($dt->year,2,2);
        my $date=join "",$month,"/",$day,"/",$yr;
}

sub wurd
{
	my $str=$_[0];
	my $num=$_[1];
	my @row=split(" ",$str);
	my $word;
	for (my $i=0; $i<$num;$i++){
		if ($row[$i]){
			$word.=$row[$i];
			if ($i!=($num-1) && scalar(@row)>1){
				$word.=" ";   
			}
		}
	}
	return $word;
}

sub says
{
	system("say program is finished");
}

1;
