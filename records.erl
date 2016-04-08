-module(records).
-compile(export_all).

-record(robot, {name, type=industrial,
                        hobbies,
                        details=[]}).
-record(user, {id, name, group, age}).

-include("records.hrl").

first_robot() ->
    #robot{name="Megatron", type=handmade, details=["Moved by a small man inside"]}.

car_factory(Corpname) ->
    #robot{name=Corpname, hobbies="building cars"}.

admin_panel(#user{name=Name, group=admin}) ->
    Name ++ " is allowed";
admin_panel(#user{name=Name}) ->
    Name ++ " is not allowed".

adult_section(U = #user{}) when U#user.age >= 18 ->
    allowed;
adult_section(_) -> forbidden.
