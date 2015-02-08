server_thread(Port) :-
	thread_create(create_server(Port), _, [alias(server)]).

stop_server :-
	thread_signal(server, abort),
	thread_join(server, _Status).

create_server(Port) :-
	setup_call_cleanup(tcp_socket(Socket),
			   (true;fail),
			   (Open == true -> true ; tcp_close_socket(Socket))),
        tcp_bind(Socket, Port),
        tcp_listen(Socket, 5),
        tcp_open_socket(Socket, AcceptFd, WriteFd),
	Open = true, !,
	call_cleanup(dispatch(AcceptFd),
		     close_connection(AcceptFd, WriteFd)).

dispatch(AcceptFd) :-
        tcp_accept(AcceptFd, Socket, Peer),
        thread_create(process_client(Socket, Peer), _,
                      [ detached(true)
                      ]),
        dispatch(AcceptFd).

process_client(Socket, _Peer) :-
        setup_call_cleanup(tcp_open_socket(Socket, In, Out),
                           handle_service(In, Out),
                           close_connection(In, Out)).

close_connection(In, Out) :-
        close(In, [force(true)]),
        close(Out, [force(true)]).

handle_service(In, Out) :-
	read(In, Term),
	writeln(Term),
	(   Term == end_of_file
	->  true
	;   format(Out, 'seen(~q).~n', [Term]),
	    flush_output(Out),
	    handle_service(In, Out)
	).

%%	client

create_client(Host, Port) :-
        setup_call_catcher_cleanup(tcp_socket(Socket),
                                   tcp_connect(Socket, Host:Port),
                                   exception(_),
                                   tcp_close_socket(Socket)),
        setup_call_cleanup(tcp_open_socket(Socket, In, Out),
                           chat_to_server(In, Out),
                           close_connection(In, Out)).

chat_to_server(In, Out) :-
        read(Term),
	(   Term == end_of_file
	->  true
	;   format(Out, '~q .~n', [Term]),
	    flush_output(Out),
	    read(In, Reply),
	    format('Reply: ~q.~n', [Reply]),
	    chat_to_server(In, Out)
	).


