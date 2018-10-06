# description: verification graphs
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

#set nokey
set grid xtics ytics
set timestamp "%Y-%d-%m %T%z" font ',8'
set term pngcairo enhanced font 'Roboto Condensed' size 898,898
set output 'verification.png'

set multiplot layout 2,1 title 'Verification testing Nuspell vs. Hunspell' font ',14'



#set style data lines
#set timefmt '%d/%m/%y\t%H%M'
set xlabel 'commit date and time'
set xtics 1 rotate by -45

set ylabel 'verification'
set yrange [0:]
set format y '%.1f'
set ytics nomirror

set y2label 'accuracy'
set y2tics nomirror 1
set y2range [:1]

plot \
'linux_katana-latest.tsv' u 0:7:5:6:8 w candlesticks lc rgb 'blueviolet' t 'verification' whiskerbars 1.5, \
'' using 0:4:4:4:4 w candlesticks lt -1 lw 2 notitle, \
'' using 0:12 w l axes x1y2 t 'accuracy'



set xlabel 'commit git handle'

set ylabel 'speed-up'

set y2label '# languages'
set y2range [*:*]

plot \
'linux_katana-latest.tsv' u 0:7:5:6:8 w candlesticks t 'speed-up' whiskerbars 1.5, \
'' using 0:4:4:4:4 w candlesticks lt -1 lw 2 notitle, \
'' using 0:3 w histeps axes x1y2 lc rgb 'blue' t '# languages'



unset multiplot
