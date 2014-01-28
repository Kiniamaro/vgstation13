
////////////////////////////////////////////
// Injector
////////////////////////////////////////////
/datum/automation/set_injector_power
	name = "Injector: Power"
	var/injector=null
	var/state=0

	valid_child_returntypes=list(AUTOM_RT_NUM)

	New(var/obj/machinery/computer/general_air_control/atmos_automation/aa)
		..(aa)

	process()
		if(injector)
			parent.send_signal(list ("tag" = injector, "power"=state))
		return 0

	GetText()
		return "Set injector <a href=\"?src=\ref[src];set_injector=1\">[fmtString(injector)]</a> power to <a href=\"?src=\ref[src];toggle_state=1\">[state ? "on" : "off"]</a>."

	Topic(href,href_list)
		if(href_list["toggle_state"])
			state = !state
			parent.updateUsrDialog()
			return 1
		if(href_list["set_injector"])
			var/list/injector_names=list()
			for(var/obj/machinery/atmospherics/unary/outlet_injector/I in machines)
				if(!isnull(I.id) && I.frequency == parent.frequency)
					injector_names|=I.id
			injector = input("Select an injector:", "Sensor Data", injector) as null|anything in injector_names
			parent.updateUsrDialog()
			return 1