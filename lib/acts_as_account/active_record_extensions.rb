module ActsAsAccount
  module ActiveRecordExtension
    def self.included(base) # :nodoc:
      base.extend ClassMethods
      base.class_eval do
        def account(name = :default)
          __send__("#{name}_account") || __send__("create_#{name}_account", :name => name.to_s) 
        end
        
        establish_connection("#{RAILS_ENV}_acts_as_account") if defined? RAILS_ENV
      end
    end
  
    module ClassMethods
      def has_account(name = :default)
        has_one "#{name}_account", :conditions => "name = '#{name}'", :class_name => "ActsAsAccount::Account", :as => :holder
      end
    end
  end
end