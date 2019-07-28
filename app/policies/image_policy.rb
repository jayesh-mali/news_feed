class ImagePolicy < ApplicationPolicy

    def create?
      user.has_any_role? Role::ADMIN
    end

    def show?
      user.has_role?(Role::ADMIN) ? true :  (record.created_by_id == user.id)
    end

    def destroy?
        show?
    end

end
