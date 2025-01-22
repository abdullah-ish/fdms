WITHOUT_SUBDOMAIN_CONTOLLER_ACTIONS = {
  "users/sessions" => [{
    "action" => "new",
    "request_type" => "GET"
  },
   {
    "action" => "create",
    "request_type" => "POST"
  }],

  "users/registrations" => [{
    "action" => "new",
    "request_type" => "GET"
  },
   {
    "action" => "create",
    "request_type" => "POST"
  },
],

  "devise/confirmations" => [{
    "action" => "show",
    "request_type" => "GET",
  },
  {
    "action" => "new",
    "request_type" => "GET",
  },
  {
    "action" => "create",
    "request_type" => "POST",
  }
],

"users/passwords" => [{
  "action" => "new",
  "request_type" => "GET",
},
{
  "action" => "create",
  "request_type" => "POST",
},
{
  "action" => "edit",
  "request_type" => "GET",
},
{
  "action" => "update",
  "request_type" => "POST",
}],

  "homes" => [{
    "action" => "index",
    "request_type" => "GET",
  }],

  "active_admin/devise/sessions" => [{
    "action" => "new",
    "request_type" => "GET",
  },
  {
    "action" => "create",
    "request_type" => "POST",
  }]
  

  #   "admins/sessions" => [{
  #   "action" => "new",
  #   "request_type" => "GET",
  # },
  # {
  #   "action" => "create",
  #   "request_type" => "POST",
  # }]
}