%
% ystockquote : Erlang module - retrieve stock quote data from Yahoo Finance
% license: GNU LGPL
%
% Copyright (c) 2015 Andrey Lisin (andrey dot lisin [at] gmail dot com).
%
% This module is free software; you can redistribute it and/or modify it under
% the terms of the GNU Lesser General Public License as published by the Free
% Software Foundation; either version 2.1 of the License, or (at your option)
% any later version.
%
% This module is reimplementation of Corey Goldberg's Python ystockquotes
% library, which can be found here: https://github.com/cgoldberg/ystockquote
%
-module(ystockquote).
-author("Andrey Lisin").

-export([request/2,
         get_all/1, get_dividend_yield/1,
         get_dividend_per_share/1, get_ask_realtime/1,
         get_dividend_pay_date/1,
         get_bid_realtime/1,
         get_ex_dividend_date/1,
         get_previous_close/1,
         get_today_open/1,
         get_change/1,
         get_last_trade_date/1,
         get_change_percent_change/1,
         get_trade_date/1,
         get_change_realtime/1,
         get_last_trade_time/1,
         get_change_percent_realtime/1,
         get_change_percent/1,
         get_after_hours_change/1,
         get_change_200_sma/1,
         get_commission/1,
         get_percent_change_200_sma/1,
         get_todays_low/1,
         get_change_50_sma/1,
         get_todays_high/1,
         get_percent_change_50_sma/1,
         get_last_trade_realtime_time/1,
         get_50_sma/1,
         get_last_trade_time_plus/1,
         get_200_sma/1,
         get_last_trade_price/1,
         get_1_year_target/1,
         get_todays_value_change/1,
         get_holdings_gain_percent/1,
         get_todays_value_change_realtime/1,
         get_annualized_gain/1,
         get_price_paid/1,
         get_holdings_gain/1,
         get_todays_range/1,
         get_holdings_gain_percent_realtime/1,
         get_todays_range_realtime/1,
         get_holdings_gain_realtime/1,
         get_52_week_high/1,
         get_more_info/1,
         get_52_week_low/1,
         get_market_cap/1,
         get_change_from_52_week_low/1,
         get_market_cap_realtime/1,
         get_change_from_52_week_high/1,
         get_float_shares/1,
         get_percent_change_from_52_week_low/1,
         get_company_name/1,
         get_percent_change_from_52_week_high/1,
         get_notes/1,
         get_52_week_range/1,
         get_shares_owned/1,
         get_stock_exchange/1,
         get_shares_outstanding/1,
         get_volume/1,
         get_ask_size/1,
         get_bid_size/1,
         get_last_trade_size/1,
         get_ticker_trend/1,
         get_average_daily_volume/1,
         get_trade_links/1,
         get_order_book_realtime/1,
         get_high_limit/1,
         get_eps/1,
         get_low_limit/1,
         get_eps_estimate_current_year/1,
         get_holdings_value/1,
         get_eps_estimate_next_year/1,
         get_holdings_value_realtime/1,
         get_eps_estimate_next_quarter/1,
         get_revenue/1,
         get_book_value/1,
         get_ebitda/1,
         get_price_sales/1,
         get_price_book/1,
         get_pe/1,
         get_pe_realtime/1,
         get_peg/1,
         get_price_eps_estimate_current_year/1,
         get_price_eps_estimate_next_year/1,
         get_short_ratio/1]).

request(Symbol, Stat) ->
    application:start(inets),
    Url = io_lib:format(
            "http://finance.yahoo.com/d/quotes.csv?s=~s&f=~s",
            [Symbol, Stat]
           ),
    {ok, {{_HttpVer, _Code, _Msg}, _Headers, Body}} =
        httpc:request(get, {Url, [{"User-Agent", "Erlang"}]}, [], []),
    string:strip(string:strip(Body, right, $\n), right, $\r).


get_all(Symbol) ->
    Ids = "ydb2r1b3qpoc1d1cd2c6t1k2p2c8m5c3m6gm7hm8k1m3lm4l1t8w1g1w4g3p1g4mg5m2g6kvjj1j5j3k4f6j6nk5n4ws1xj2va5b6k3t7a2t615l2el3e7v1e8v7e9s6b4j4p5p6rr2r5r6r7s7",
    Values = string:tokens(request(Symbol, Ids), ","),
    {{dividend_yield, lists:nth(1, Values)},
      {dividend_per_share, lists:nth(2, Values)},
      {ask_realtime, lists:nth(3, Values)},
      {dividend_pay_date, lists:nth(4, Values)},
      {bid_realtime, lists:nth(5, Values)},
      {ex_dividend_date, lists:nth(6, Values)},
      {previous_close, lists:nth(7, Values)},
      {today_open, lists:nth(8, Values)},
      {change, lists:nth(9, Values)},
      {last_trade_date, lists:nth(10, Values)},
      {change_percent_change, lists:nth(11, Values)},
      {trade_date, lists:nth(12, Values)},
      {change_realtime, lists:nth(13, Values)},
      {last_trade_time, lists:nth(14, Values)},
      {change_percent_realtime, lists:nth(15, Values)},
      {change_percent, lists:nth(16, Values)},
      {after_hours_change_realtime, lists:nth(17, Values)},
      {change_00_sma, lists:nth(18, Values)},
      {todays_low, lists:nth(19, Values)},
      {change_50_sma, lists:nth(20, Values)},
      {todays_high, lists:nth(21, Values)},
      {percent_change_50_sma, lists:nth(22, Values)},
      {last_trade_realtime_time, lists:nth(23, Values)},
      {fifty_sma, lists:nth(24, Values)},
      {last_trade_time_plus, lists:nth(25, Values)},
      {twohundred_sma, lists:nth(26, Values)},
      {last_trade_price, lists:nth(27, Values)},
      {one_year_target, lists:nth(28, Values)},
      {todays_value_change, lists:nth(29, Values)},
      {holdings_gain_percent, lists:nth(30, Values)},
      {todays_value_change_realtime, lists:nth(31, Values)},
      {annualized_gain, lists:nth(32, Values)},
      {price_paid, lists:nth(33, Values)},
      {holdings_gain, lists:nth(34, Values)},
      {todays_range, lists:nth(35, Values)},
      {holdings_gain_percent_realtime, lists:nth(36, Values)},
      {todays_range_realtime, lists:nth(37, Values)},
      {holdings_gain_realtime, lists:nth(38, Values)},
      {fiftytwo_week_high, lists:nth(39, Values)},
      {more_info, lists:nth(40, Values)},
      {fiftytwo_week_low, lists:nth(41, Values)},
      {market_cap, lists:nth(42, Values)},
      {change_from_5_week_low, lists:nth(43, Values)},
      {market_cap_realtime, lists:nth(44, Values)},
      {change_from_5_week_high, lists:nth(45, Values)},
      {float_shares, lists:nth(46, Values)},
      {percent_change_from_5_week_low, lists:nth(47, Values)},
      {company_name, lists:nth(48, Values)},
      {percent_change_from_5_week_high, lists:nth(49, Values)},
      {notes, lists:nth(50, Values)},
      {fiftytwo_week_range, lists:nth(51, Values)},
      {shares_owned, lists:nth(52, Values)},
      {stock_exchange, lists:nth(53, Values)},
      {shares_outstanding, lists:nth(54, Values)},
      {volume, lists:nth(55, Values)},
      {ask_size, lists:nth(56, Values)},
      {bid_size, lists:nth(57, Values)},
      {last_trade_size, lists:nth(58, Values)},
      {ticker_trend, lists:nth(59, Values)},
      {average_daily_volume, lists:nth(60, Values)},
      {trade_links, lists:nth(61, Values)},
      {order_book_realtime, lists:nth(62, Values)},
      {high_limit, lists:nth(63, Values)},
      {eps, lists:nth(64, Values)},
      {low_limit, lists:nth(65, Values)},
      {eps_estimate_current_year, lists:nth(66, Values)},
      {holdings_value, lists:nth(67, Values)},
      {eps_estimate_next_year, lists:nth(68, Values)},
      {holdings_value_realtime, lists:nth(69, Values)},
      {eps_estimate_next_quarter, lists:nth(70, Values)},
      {revenue, lists:nth(71, Values)},
      {book_value, lists:nth(72, Values)},
      {ebitda, lists:nth(73, Values)},
      {price_sales, lists:nth(74, Values)},
      {price_book, lists:nth(75, Values)},
      {pe, lists:nth(76, Values)},
      {pe_realtime, lists:nth(77, Values)},
      {peg, lists:nth(78, Values)},
      {price_eps_estimate_current_year, lists:nth(79, Values)},
      {price_eps_estimate_next_year, lists:nth(80, Values)},
      {short_ratio, lists:nth(81, Values)}}.


get_dividend_yield(Symbol) ->
    request(Symbol, "y").


get_dividend_per_share(Symbol) ->
    request(Symbol, "d").


get_ask_realtime(Symbol) ->
    request(Symbol, "b2").


get_dividend_pay_date(Symbol) ->
    request(Symbol, "r1").


get_bid_realtime(Symbol) ->
    request(Symbol, "b3").


get_ex_dividend_date(Symbol) ->
    request(Symbol, "q").


get_previous_close(Symbol) ->
    request(Symbol, "p").


get_today_open(Symbol) ->
    request(Symbol, "o").


get_change(Symbol) ->
    request(Symbol, "c1").


get_last_trade_date(Symbol) ->
    request(Symbol, "d1").


get_change_percent_change(Symbol) ->
    request(Symbol, "c").


get_trade_date(Symbol) ->
    request(Symbol, "d2").


get_change_realtime(Symbol) ->
    request(Symbol, "c6").


get_last_trade_time(Symbol) ->
    request(Symbol, "t1").


get_change_percent_realtime(Symbol) ->
    request(Symbol, "k2").


get_change_percent(Symbol) ->
    request(Symbol, "p2").


get_after_hours_change(Symbol) ->
    request(Symbol, "c8").


get_change_200_sma(Symbol) ->
    request(Symbol, "m5").


get_commission(Symbol) ->
    request(Symbol, "c3").


get_percent_change_200_sma(Symbol) ->
    request(Symbol, "m6").


get_todays_low(Symbol) ->
    request(Symbol, "g").


get_change_50_sma(Symbol) ->
    request(Symbol, "m7").


get_todays_high(Symbol) ->
    request(Symbol, "h").


get_percent_change_50_sma(Symbol) ->
    request(Symbol, "m8").


get_last_trade_realtime_time(Symbol) ->
    request(Symbol, "k1").


get_50_sma(Symbol) ->
    request(Symbol, "m3").


get_last_trade_time_plus(Symbol) ->
    request(Symbol, "l").


get_200_sma(Symbol) ->
    request(Symbol, "m4").


get_last_trade_price(Symbol) ->
    request(Symbol, "l1").


get_1_year_target(Symbol) ->
    request(Symbol, "t8").


get_todays_value_change(Symbol) ->
    request(Symbol, "w1").


get_holdings_gain_percent(Symbol) ->
    request(Symbol, "g1").


get_todays_value_change_realtime(Symbol) ->
    request(Symbol, "w4").


get_annualized_gain(Symbol) ->
    request(Symbol, "g3").


get_price_paid(Symbol) ->
    request(Symbol, "p1").


get_holdings_gain(Symbol) ->
    request(Symbol, "g4").


get_todays_range(Symbol) ->
    request(Symbol, "m").


get_holdings_gain_percent_realtime(Symbol) ->
    request(Symbol, "g5").


get_todays_range_realtime(Symbol) ->
    request(Symbol, "m2").


get_holdings_gain_realtime(Symbol) ->
    request(Symbol, "g6").


get_52_week_high(Symbol) ->
    request(Symbol, "k").


get_more_info(Symbol) ->
    request(Symbol, "v").


get_52_week_low(Symbol) ->
    request(Symbol, "j").


get_market_cap(Symbol) ->
    request(Symbol, "j1").


get_change_from_52_week_low(Symbol) ->
    request(Symbol, "j5").


get_market_cap_realtime(Symbol) ->
    request(Symbol, "j3").


get_change_from_52_week_high(Symbol) ->
    request(Symbol, "k4").


get_float_shares(Symbol) ->
    request(Symbol, "f6").


get_percent_change_from_52_week_low(Symbol) ->
    request(Symbol, "j6").


get_company_name(Symbol) ->
    request(Symbol, "n").


get_percent_change_from_52_week_high(Symbol) ->
    request(Symbol, "k5").


get_notes(Symbol) ->
    request(Symbol, "n4").


get_52_week_range(Symbol) ->
    request(Symbol, "w").


get_shares_owned(Symbol) ->
    request(Symbol, "s1").


get_stock_exchange(Symbol) ->
    request(Symbol, "x").


get_shares_outstanding(Symbol) ->
    request(Symbol, "j2").


get_volume(Symbol) ->
    request(Symbol, "v").


get_ask_size(Symbol) ->
    request(Symbol, "a5").


get_bid_size(Symbol) ->
    request(Symbol, "b6").


get_last_trade_size(Symbol) ->
    request(Symbol, "k3").


get_ticker_trend(Symbol) ->
    request(Symbol, "t7").


get_average_daily_volume(Symbol) ->
    request(Symbol, "a2").


get_trade_links(Symbol) ->
    request(Symbol, "t6").


get_order_book_realtime(Symbol) ->
    request(Symbol, "i5").


get_high_limit(Symbol) ->
    request(Symbol, "l2").


get_eps(Symbol) ->
    request(Symbol, "e").


get_low_limit(Symbol) ->
    request(Symbol, "l3").


get_eps_estimate_current_year(Symbol) ->
    request(Symbol, "e7").


get_holdings_value(Symbol) ->
    request(Symbol, "v1").


get_eps_estimate_next_year(Symbol) ->
    request(Symbol, "e8").


get_holdings_value_realtime(Symbol) ->
    request(Symbol, "v7").


get_eps_estimate_next_quarter(Symbol) ->
    request(Symbol, "e9").


get_revenue(Symbol) ->
    request(Symbol, "s6").


get_book_value(Symbol) ->
    request(Symbol, "b4").


get_ebitda(Symbol) ->
    request(Symbol, "j4").


get_price_sales(Symbol) ->
    request(Symbol, "p5").


get_price_book(Symbol) ->
    request(Symbol, "p6").


get_pe(Symbol) ->
    request(Symbol, "r").


get_pe_realtime(Symbol) ->
    request(Symbol, "r2").


get_peg(Symbol) ->
    request(Symbol, "r5").


get_price_eps_estimate_current_year(Symbol) ->
    request(Symbol, "r6").


get_price_eps_estimate_next_year(Symbol) ->
    request(Symbol, "r7").

get_short_ratio(Symbol) ->
    request(Symbol, "s7").
