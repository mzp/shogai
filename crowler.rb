# -*- mode:ruby; coding:utf-8 -*-
require 'open-uri'
require 'nokogiri'
require_relative 'model'

class Crowler
  Keys = {
    '千種生涯学習センター' => '1164769878',
    '東生涯学習センター'   => '1164769962',
    '北生涯学習センター'   => '1164770111',
    '西生涯学習センター'   => '1164770187',
    '中村生涯学習センター' => '1164770263',
    '中生涯学習センター'   => '1164770343',
    '昭和生涯学習センター' => '1164771215',
    '瑞穂生涯学習センター' => '1164771303',
    '熱田生涯学習センター' => '1164771371',
    '中川生涯学習センター' => '1164771540',
    '港生涯学習センター'   => '1164771619',
    '南生涯学習センター'   => '1164771691',
    '守山生涯学習センター' => '1164771764',
    '緑生涯学習センター'   => '1164771836',
    '名東生涯学習センター' => '1164772237',
    '天白生涯学習センター' => '1164772307',
    '女性会館' => '1164952749'
  }

  def url(key, year, month, day)
    "http://www.suisin.city.nagoya.jp/system/institution/index.cgi?action=inst_day_view&inst_key=#{key}&year=#{year}&month=#{month}&day=#{day}"
  end

  def view(key)
    "http://www.suisin.city.nagoya.jp/system/institution/index.cgi?action=inst_view&inst_key=#{key}"
  end

  def find_by_date(year, month, day)
    date = Date.new(year,month,day)
    Keys.map do|iname, key|
      doc = Nokogiri::HTML(open(url(key, year, month, day)))
      resources = doc.css('table.empty04 tr')[2..-1].map do|elem|
        name = elem.css('th').text

        x,y,z = elem.css('td img')
        reserves = [ Reserve.new(date,"9","12.5" , x['src'] == 'img/mark01.gif'),
                     Reserve.new(date,"13","16.5", x['src'] == 'img/mark01.gif'),
                     Reserve.new(date,"17","21"  , x['src'] == 'img/mark01.gif') ]
        Resource.new name, reserves
      end
      Institution.new iname, view(key), resources
    end
  end

end

if __FILE__ == $0
  require 'pp'
  pp Crowler.new.find_by_date(2010,10,20)
end
