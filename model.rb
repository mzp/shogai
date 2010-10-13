#! /opt/local/bin/ruby -w
# -*- mode:ruby; coding:utf-8 -*-

# ------------------------------
# モデル
# ------------------------------
# 予約状況
Reserve = Struct.new 'Reserve', :date, :from, :to, :available

# リソース
Resource = Struct.new 'Resource', :name, :reserves

# 施設
Institution = Struct.new 'Institution', :name, :url, :resources
