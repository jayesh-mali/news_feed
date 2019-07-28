class PostPolicy < ApplicationPolicy

    def show?
        user.has_role?(Role::ADMIN) ? true :  (record.created_by_id == user.id)
    end

    def destroy?
        show?
    end

      
end
