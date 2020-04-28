%What is wrong with my display?
%Run with solve(fix_display(X).
%Ran with swi-prolog

%rules
:-include('exshell'). %includes the exshell 
rule((fix_display(Advice) :-  
	issue(Y), fix(Y,Advice)),100).
%The issue is the monitor when the screen is off and there is no power.
rule((issue(monitor) :- not(screen_on),not(power_on_monitor)),90).
rule((issue(monitor) :- screen_on,not(error_code_on_screen), %Screen is on, theres no error code, video cable is secured.
															%The cable is not damaged, 
															%other cards are installed, no missing pins or damaged cable
															% does not work when removing other parts,
						  video_cable_secured,
						  not(damaged_video_cable),
						  other_cards_installed,
						  not(worked_when_remove_other_parts)),70).
rule((issue(monitor) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings, on, there are no beeping noises
                                                        %video cable is  secured, cable is not damaged, other cards are installed,
     													% does not work when removing other parts. Then it is the monitor.
						monitor_default_settings_on,
						not(beeping_noises),
						video_cable_secured, 
						not(damaged_video_cable),
						other_cards_installed,
						not(worked_when_remove_other_parts)),70).
rule((issue(monitor) :- screen_on,error_code_on_screen,  %Screen is on, theres an error code, no POST test on the screen. Go into safe mode
														%POST on screen,  other cards installed,
														% does not work when remove other parts, then its the monitor
						post_test_on_screen,
						other_cards_installed,
						not(worked_when_remove_other_parts)),70).
rule((issue(default_settings) :- not(screen_on),not(power_on_monitor),
								 not(monitor_default_settings_on)),50). %If the screen is off, there is no power (assuming its plugged in),
								                                        %the monitor's default settings are off
								 										% then its the default settings
rule((issue(secure_video_card) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings on, there are beeping noises
																   % The video card isn't secured properly. The issue lies with the video card.
								monitor_default_settings_on,
								beeping_noises, 
								 not(video_card_secured)),60).
rule((issue(secure_video_cable) :- not(screen_on),power_on_monitor,  %Screen is off, monitor has power, default settings, on, there are no beeping noises
																	 %video cable is not secured, then it is the video cable
								monitor_default_settings_on,
								not(beeping_noises), 
								 not(video_cable_secured)),60).
rule((issue(secure_video_cable) :- screen_on,not(error_code_on_screen), %Screen is on, theres no error code, video cable not secured. Secure video cable
							       not(video_cable_secured)),60).
rule((issue(broken_video_cable) :- not(screen_on),power_on_monitor,%Screen is off, monitor has power, default settings, on, no beeping noises
																	   %video cable is secured, video cable is damaged, then get a new video cable
								monitor_default_settings_on,
								not(beeping_noises),
								video_cable_secured, 
							    damaged_video_cable),70).
rule((issue(broken_video_cable) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings, on, there are no beeping noises
																		%video card is  secured, cable is not damaged, ram or cpu is secured, Missing pins
																		%on cpu, Then the problem is the fact that there are missing pins
								 		monitor_default_settings_on, 
										video_card_secured, ram_cpu_secured,
										damaged_video_cable),70).
rule((issue(broken_video_cable) :- screen_on,not(error_code_on_screen), %Screen is on, theres no error code, video cable is secured.
															%The cable is not damaged, 
															%other cards are installed,  missing pins or damaged cable, then ists the missing pins or cable
						  video_cable_secured,
						  not(damaged_video_cable),
						  other_cards_installed,
						  not(worked_when_remove_other_parts)),70).
rule((issue(broken_video_cable) :- screen_on,not(error_code_on_screen), %Screen is on, theres no error code, video cable is secured.
																			%The cable is damaged, then its the cable
								   video_cable_secured,
								   damaged_video_cable),70).
rule((issue(video_adapter_failure) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings, on, there are no beeping noises
																	  %video cable is  secured, cable is not damaged, no other cards are installed,
																	  %works with a different video card. Then the issue is the video adapter failing
								monitor_default_settings_on,
								not(beeping_noises),
								video_cable_secured, 
								not(damaged_video_cable),
								not(other_cards_installed),
								works_with_diff_video_card),90).
rule((issue(video_adapter_failure) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings, on, there are no beeping noises
																	   %video card is  secured, cable is not damaged, ram or cpu is secured, no missing pins
																	   %on cpu, no other cards are installed, works with a different card.
																	   % The problem is the video adapter failing
								monitor_default_settings_on, 
								video_card_secured, ram_cpu_secured,
								not(damaged_video_cable),		
								not(other_cards_installed),
								works_with_diff_video_card),70).
rule((issue(video_adapter_failure) :- screen_on,not(error_code_on_screen), %Screen is on, theres no error code, video cable is secured.
																			%The cable is not damaged, 
																			%no other cards are installed, works with a different video card,
																			%then the video adapter is failing.
                                      video_cable_secured,
							         not(damaged_video_cable),
									 not(other_cards_installed),
								     works_with_diff_video_card),70).
rule((issue(reset_bios) :- not(screen_on),power_on_monitor,  %Screen is off, monitor has power, default settings, on, there are no beeping noises
															 %video cable is  secured, cable is not damaged, other cards are installed,
                                                             %works when remove other parts. Then problem is the bios. Reset it.
							monitor_default_settings_on,
							not(beeping_noises),
							video_cable_secured, 
							not(damaged_video_cable),
							other_cards_installed,
							worked_when_remove_other_parts),80).
rule((issue(reset_bios) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings, on, there are no beeping noises
															%video card is  secured, cable is not damaged, ram or cpu is secured, no missing pins
															%on cpu, other cards installed, works when remove the other parts. Then its the bios. Reset it
							monitor_default_settings_on, 
							video_card_secured, ram_cpu_secured,
							not(damaged_video_cable),		
							other_cards_installed,
							worked_when_remove_other_parts),80).
rule((issue(reset_bios) :- screen_on,error_code_on_screen, %Screen is on, theres an error code, no POST test on the screen. Go into safe mode
															%POST on screen,  other cards installed,
															% works when remove other parts, then reset bios
								post_test_on_screen,
								other_cards_installed,
								worked_when_remove_other_parts),80).
rule((issue(reset_bios) :- screen_on,not(error_code_on_screen), %Screen is on, theres no error code, video cable is secured.
																%The cable is not damaged, 
																%other cards are installed,works when removing other parts,
																%Reset the bios.
						  video_cable_secured,
						  other_cards_installed,
						  worked_when_remove_other_parts),80).

rule((issue(secure_cpu_ram) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings, on, there are no beeping noises
																%video card is  secured, cable is not damaged, ram or cpu is not secured. Then
																%secure ram or cpu
								monitor_default_settings_on, 
								video_card_secured, not(ram_cpu_secured)),60).


rule((issue(motherboard_issue) :- not(screen_on),power_on_monitor, %Screen is off, monitor has power, default settings, on, there are no beeping noises
																   %video card is  secured, cable is not damaged, ram or cpu is secured, no missing pins
																   %on cpu, no other cards are installed, does not work with a different video card, 
																   %its the motherboard
							monitor_default_settings_on, 
							video_card_secured, ram_cpu_secured,
							not(damaged_video_cable),		
							not(other_cards_installed),
							not(works_with_diff_video_card)),80).
rule((issue(motherboard_issue) :- screen_on,error_code_on_screen, %Screen is on, theres an error code, no POST test on the screen. Go into safe mode
																	%POST on screen, no other cards installed,
																	% does not work with a different video card,
																	%Its the motherboard
								post_test_on_screen,
								not(other_cards_installed),
								not(works_with_diff_video_card)),80).
rule((issue(motherboard_issue) :- screen_on,not(error_code_on_screen), %Screen is on, theres no error code, video cable is secured.
																		%The cable is not damaged, 
																		%no other cards are installed, does not work with a different video card,
																		%then its the motherboard
								  video_cable_secured,
								  not(damaged_video_cable),
								  not(other_cards_installed),
								  not(works_with_diff_video_card)),80).



rule((issue(go_to_safe_mode) :- screen_on,error_code_on_screen,  %Screen is on, theres an error code, no POST test on the screen. Go into safe mode
																 %and clean OS installation
						   not(post_test_on_screen)),50). 






								  
							

%%These will trigger a fix for the display								
rule(fix(monitor,'replace or repair monitor'),90).
rule(fix(default_settings,'Turn monitor default settings on'),50).
rule(fix(secure_video_card,'Secure the video card'),60).
rule(fix(secure_cpu_ram,'Secure the cpu and ram'),60).
rule(fix(broken_video_cable,'Fix the video cable'),70).
rule(fix(video_adapter_failure,'The problem lies with your video adapter failing'),70).
rule(fix(motherboard_issue,'The problem lies with your motherboard'),80).
rule(fix(reset_bios,'Reset the BIOS'),90).
rule(fix(go_to_safe_mode,'Go to safe mode and clean the OS installation'),50).
rule(fix(secure_video_cable,'Secure your video cable'),60).

%Questions to ask
askable(screen_on).
askable(power_on_monitor).
askable(error_code_on_screen).
askable(monitor_default_settings_on).
askable(beeping_noises).
askable(ram_cpu_secured).
askable(video_card_secured).
askable(video_cable_secured).
askable(damaged_video_cable).
askable(post_test_on_screen).
askable(other_cards_installed).
askable(works_with_diff_video_card).
askable(worked_when_remove_other_parts).
%%TEST EXAMPLE 1 
%|    solve(fix_display(X)).
%screen_on? n.
%power_on_monitor? |: y.
%monitor_default_settings_on? |: y.
%beeping_noises? |: y.
%video_card_secured? |: why.
%IF       not(screen_on)     ***Known, Certainty = 100
%     AND power_on_monitor     ***Known, Certainty = 100
%     AND monitor_default_settings_on     ***Known, Certainty = 100
%     AND beeping_noises     ***Known, Certainty = 100
%     AND not(video_card_secured)
%THEN     issue(secure_video_card)
%CF   60

%video_card_secured? |: y.
%ram_cpu_secured? |: y.
%damaged_video_cable? |: n.
%other_cards_installed? |: why.
%IF       not(screen_on)     ***Known, Certainty = 100
%     AND power_on_monitor     ***Known, Certainty = 100
%     AND monitor_default_settings_on     ***Known, Certainty = 100
%     AND video_card_secured     ***Known, Certainty = 100
%     AND ram_cpu_secured     ***Known, Certainty = 100
%     AND not(damaged_video_cable)     ***Known, Certainty = 100
%     AND not(other_cards_installed)
%     AND works_with_diff_video_card
%THEN     issue(video_adapter_failure)
%CF   70

%other_cards_installed? |: y.
%worked_when_remove_other_parts? |: y.

%Solved fix_display(Reset the BIOS) With Certainty = 80

%Trace of reasoning to goal ? |: y.

%fix_display(Reset the BIOS) CF = 80
%was proved using the rule

%IF       issue(reset_bios)     ***Known, Certainty = 80
%     AND fix(reset_bios,Reset the BIOS)     ***Known, Certainty = 90
%THEN     fix_display(Reset the BIOS)
%CF   100

%issue(reset_bios) CF = 80
%was proved using the rule
%IF       not(screen_on)     ***Known, Certainty = 100
%     AND power_on_monitor     ***Known, Certainty = 100
%     AND monitor_default_settings_on     ***Known, Certainty = 100
%     AND video_card_secured     ***Known, Certainty = 100
%     AND ram_cpu_secured     ***Known, Certainty = 100
%     AND not(damaged_video_cable)     ***Known, Certainty = 100
%     AND other_cards_installed     ***Known, Certainty = 100
%     AND worked_when_remove_other_parts     ***Known, Certainty = 100
%THEN     issue(reset_bios)
%CF   80

%not screen_on CF = 100
%screen_on was given. CF = -100
%power_on_monitor was given. CF = 100
%monitor_default_settings_on was given. CF = 100
%video_card_secured was given. CF = 100
%ram_cpu_secured was given. CF = 100
%not damaged_video_cable CF = 100
%damaged_video_cable was given. CF = -100
%other_cards_installed was given. CF = 100
%worked_when_remove_other_parts was given. CF = 100
%fix(reset_bios,Reset the BIOS) is a fact, CF = 90
%X = 'Reset the BIOS' .


%%TEST EXAMPLE 3
%?- solve(fix_display(X)).
%screen_on? y.
%error_code_on_screen? |: n.
%video_cable_secured? |: y.
%damaged_video_cable? |: n.
%other_cards_installed? |: why.
%IF       screen_on     ***Known, Certainty = 100
%     AND not(error_code_on_screen)     ***Known, Certainty = 100
%     AND video_cable_secured     ***Known, Certainty = 100
%     AND not(damaged_video_cable)     ***Known, Certainty = 100
%     AND other_cards_installed
%    AND not(worked_when_remove_other_parts)
%THEN     issue(monitor)
%CF   70

%other_cards_installed? |: n.
%works_with_diff_video_card? |: y.

%Solved fix_display(The problem lies with your video adapter failing) With Certainty = 70

%Trace of reasoning to goal ? |: y.

%fix_display(The problem lies with your video adapter failing) CF = 70
%was proved using the rule

%IF       issue(video_adapter_failure)     ***Known, Certainty = 70
%     AND fix(video_adapter_failure,The problem lies with your video adapter failing)     ***Known, Certainty = 70
%THEN     fix_display(The problem lies with your video adapter failing)
%CF   100

%issue(video_adapter_failure) CF = 70
%was proved using the rule

%IF       screen_on     ***Known, Certainty = 100
%     AND not(error_code_on_screen)     ***Known, Certainty = 100
%     AND video_cable_secured     ***Known, Certainty = 100
%     AND not(damaged_video_cable)     ***Known, Certainty = 100
%     AND not(other_cards_installed)     ***Known, Certainty = 100
%     AND works_with_diff_video_card     ***Known, Certainty = 100
%THEN     issue(video_adapter_failure)
%CF   70

%screen_on was given. CF = 100
%not error_code_on_screen CF = 100
%error_code_on_screen was given. CF = -100
%video_cable_secured was given. CF = 100
%not damaged_video_cable CF = 100
%damaged_video_cable was given. CF = -100
%not other_cards_installed CF = 100
%other_cards_installed was given. CF = -100
%works_with_diff_video_card was given. CF = 100
%fix(video_adapter_failure,The problem lies with your video adapter failing) is a fact, CF = 70
%X = 'The problem lies with your video adapter failing' .


%%TEST EXAMPLE 3

%?- solve(fix_display(X)).
%screen_on? n.
%power_on_monitor? |: n.

%Solved fix_display(replace or repair monitor) With Certainty = 90

%Trace of reasoning to goal ? |: y.

%fix_display(replace or repair monitor) CF = 90
%was proved using the rule

%IF       issue(monitor)     ***Known, Certainty = 90
%     AND fix(monitor,replace or repair monitor)     ***Known, Certainty = 90
%THEN     fix_display(replace or repair monitor)
%CF   100

%issue(monitor) CF = 90
%was proved using the rule

%IF       not(screen_on)     ***Known, Certainty = 100
%     AND not(power_on_monitor)     ***Known, Certainty = 100
%THEN     issue(monitor)
%CF   90

%not screen_on CF = 100
%screen_on was given. CF = -100
%not power_on_monitor CF = 100
%power_on_monitor was given. CF = -100
%fix(monitor,replace or repair monitor) is a fact, CF = 90
%X = 'replace or repair monitor' .