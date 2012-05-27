use strict;
use warnings;
use Net::Amazon;
use Net::Amazon::Request::ASIN;
use Az qw(Ser Iaz respstr detitle princo orz ort changename);
use Cot qw(load ofwhole daymark timemark perlrun says);
use Prit qw(prin printfa printfad prins);

$ARGV[0] or die;

my $file=$ARGV[0];

my $ua = Iaz;

my @lines=load($file);
my $size=scalar(@lines);

my @arl;
my @titles;
my @ak;
	
for (my $i=0;$i<$size;$i+=10){
	my @serial;
	prin ofwhole($i,$size);

	for (my $j=$i;$j<($i+10);$j++){
		if ($j<$size){
			push(@serial,$lines[$j]);
		}
	}

	my $resp = $ua->search(asin => \@serial);

	respstr($resp,"tester.txt");

	foreach ($resp->properties){
		push(@ak,ainfo($_));
		my $fh=Ser($_->ASIN);
		push(@titles,ort($_->ProductName));
		checkwriteprice($fh,$_);

		my $ifile=changename(2,$fh,"file","ifile");
		my @oddline=oddinfo($_);
		printfad($ifile,\@oddline);

		foreach ($_->similar_asins){
			push(@arl,$_);
		} 
	}
}

my $fmore=changename(1,$file,"more");
printfa($fmore,\@arl);

my $ftitle=changename(1,$file,"title");
printfa($ftitle,\@titles);

my $fname=changename(1,$file,"info");
printfa($fname,\@ak);

prin timemark;
says;

sub ainfo
{
        my $prop=$_[0];
        my $line=princo($prop->ASIN);
        $line.=princo(orz($prop->UsedPrice));
        $line.=princo(orz($prop->ListPrice));
        $line.=princo(orz($prop->SalesRank));
        $line.=princo(orz($prop->UsedCount));
        $line.=princo(orz($prop->year));
        $line.=princo(orz($prop->OurPrice));
        return $line;
}


sub checkwriteprice
{
	my $fh=$_[0];
	my $prop=$_[1];
	my @arr=priceinfo($prop);
	if (-e $fh){
		my $price=lastprice($fh);
		my $comprice=orz($prop->UsedPrice);
		my $asin=$prop->ASIN;
		if ($price!=$comprice && $comprice!=0){
			sixtytest($comprice,$price,$asin);
			printfad($fh,\@arr);
		}
	}
	else{
		printfad($fh,\@arr);
	}
}


sub lastprice
{	
	my $fh=$_[0];
	my @sines=load($fh);
        my $lastline=(scalar(@sines))-1;
        my @row=split(",",$sines[$lastline]);
	return $row[0];
}


sub priceinfo
{
	my $prop=$_[0];
	my $line.=princo(orz($prop->UsedPrice));
	$line.=princo(daymark);
	$line.=princo(timemark);
	return $line;
}

sub oddinfo
{
	my $prop=$_[0];
        my $line.=princo(orz($prop->UsedPrice));
        $line.=princo(orz($prop->ListPrice));
        $line.=princo(orz($prop->SalesRank));
        $line.=princo(orz($prop->UsedCount));
        $line.=princo(orz($prop->year));
	$line.=princo(daymark);
	$line.=princo(timemark);
        return $line;
}

sub sixtytest
{
	my ($num,$denom,$asin)=@_;
	if (ofwhole($num,$denom)<60){
		perlrun("amo.pl",$asin);
	} 
}


