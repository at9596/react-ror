class Task < ApplicationRecord
    scope :completed, -> {
        where(completed: true)
    }

end
