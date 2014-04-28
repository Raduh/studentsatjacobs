require 'net/ldap'

module UsersHelper
    def testCredentials(user, pass)
        ldap = Net::LDAP.new
        ldap.host = "jacobs.jacobs-university.de"
        ldap.port = 389
        ldap.auth "jacobs\\#{user}", pass
        if (ldap.bind)
            return 0
        else
            return 1
        end
        rescue Exception
            return 2;
    end
end
