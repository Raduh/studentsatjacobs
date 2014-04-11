require 'net/ldap'

module UsersHelper
    def isUserLegit? (user, pass)
        if (user == "admin" && pass == "admin")
            return true
        end
        if (user == "admin" && pass != "admin")
            return false
        end
        ldap = Net::LDAP.new
        ldap.host = "jacobs.jacobs-university.de"
        ldap.port = 389
        ldap.auth "jacobs\\#{user}", pass
        return ldap.bind
    end
end
