class UserRepository
  class << self
    def persist!(user)
      if user.id.present?
        User.update(user.id, record_attributes(user))
      else
        record = User.create!(record_attributes(user))
        build_entity!(record)
      end
    end

    def find!(id)
      build_entity!(User.find(id))
    end

    def all
      User.all.map(&method(:build_entity!))
    end

    private

    def build_entity!(record)
      UserEntity.build!(
        name: record.name,
        email: record.email,
        id: record.id
      )
    end

    def record_attributes(entity)
      {
        name: entity.name,
        email: entity.email
      }
    end
  end
end
