def login(user)
    click_on 'Anfitrião'
    fill_in 'E-mail', with: 'andre@pousadaria.com'
    fill_in 'Senha', with: 'password'
    within('.new_user') do
        click_on 'Entrar'
    end
end