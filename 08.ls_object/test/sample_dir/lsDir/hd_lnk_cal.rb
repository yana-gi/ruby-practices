# !/usr/bin/env ruby
require 'optparse'
require 'date'

# 引数付きショートネームオプションの設定
# -m:表示月 -y:表示年
# オプションに引数が設定されていない場合、エラー
begin
  options = ARGV.getopts( 'm:y:' )
rescue OptionParser::MissingArgument
  puts 'option requires an argument'
  exit
end

# 入力値を取得
# nilの場合、現在の年月を代入
cal_mon = options['m'] ||= Date.today.month
cal_year = options['y'] ||= Date.today.year
 
# 年月を数値型に変換
cal_mon = cal_mon.to_i
cal_year = cal_year.to_i

# 月の入力値チェック
# 範囲が1-12の数値ではない場合、エラー
unless cal_mon >= 1 && cal_mon <= 12
  puts "cal: #{cal_mon} is neither a month number (1..12) nor a name"
  exit
end

# 年の入力値チェック
# 範囲が1950-2100の数値ではない場合、エラー
unless cal_year >= 1950 && cal_year <= 2100
  puts "cal: year `#{cal_year} ' not in range 1950..2100"
  exit
end

# カレンダー開始日/終了日作成
first_day = Date.new(cal_year, cal_mon, 1)
last_day = Date.new(cal_year, cal_mon, -1)

# 表示年月の表示
puts "#{first_day.month}月 #{first_day.year}".rjust(13)

# 曜日の表示
['日','月','火','水','木','金','土'].each { |week| print week.rjust(2) }
print "\n"

# 日の表示
(first_day..last_day).each do |d|
  print (''.rjust(3)) * d.wday if d.day == 1
  print d.day.to_s.rjust(3)
  print "\n" if d.wday == 6 || d == last_day 
end
