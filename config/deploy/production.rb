# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

# deploy roles
role :app, %w{rishi@rishighan.com}
role :web, %w{rishi@rishighan.com}
role :db,  %w{rishi@rishighan.com}

set :stage, :production
server 'rishighan.com', user: 'rishi', roles: %w{web app}

#RVM stuff
set :rvm_type, :user

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

#server 'rishighan.com', user: 'rishi', roles: %w{web app}


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
set :ssh_options, {
    keys: %w(/Users/roweandesign/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w{publickey},
    #verbose: :debug,
    user: fetch(:user)
  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
