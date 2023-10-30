require 'rails_helper'

describe 'Usuário ve a home' do
    it 'com sucesso' do
        visit root_path

        expect(page).to have_content 'Pousadaria'
    end

end