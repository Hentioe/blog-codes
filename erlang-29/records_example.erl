-module(records_example).
-export([native_records_opes/0]).

% 声明原生 records
-record #user{ % <- 注意 # 号
    id = -1 :: integer(),
    name :: binary(),
    city = <<"unknown">> :: binary()
}.

native_records_opes() ->
    % 创建一个 user 原生记录
    User = #user{id = 1, name = <<"Alice">>, city = <<"New York">>},
    % 访问原生记录的字段
    io:format(
        "ID: ~p, Name: ~p, City: ~p~n",
        [User#user.id, User#user.name, User#user.city]
    ),
    % 更新 user 的字段
    NewUser = User#user{city = <<"Los Angeles">>},
    io:format("Updated City: ~p~n", [NewUser#user.city]),
    % 模式匹配
    #user{id = Id, name = Name} = User,
    io:format("Pattern Matched ID: ~p, Name: ~p~n", [Id, Name]).
