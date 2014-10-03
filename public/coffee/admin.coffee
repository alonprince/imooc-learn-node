$ () ->
	$('.del').click (e) ->
		target = $ e.target
		id = target.data 'id'
		tr = $ ".item-id-#{id}"

		$.ajax(
			type: 'DELETE'
			url: "/admin/list?id=#{id}"
		).done (results) ->
			if results.success == 1
				tr.remove() if tr.length > 0