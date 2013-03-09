require 'bcrypt'
require 'password_policy'

describe 'PasswordPolicy' do
  let(:user) { user = double('salted_user',
                             :password_salt => 'salt',
                             :password_salt= => nil,
                             :password_hash= => nil)
  }

  before(:each) do
    BCrypt::Engine.stub(:hash_secret).with(anything, anything).and_return('password')
  end

  it 'should generate a salt when securing a user without a salt' do
    user.should_receive(:password_salt).and_return(nil)
    BCrypt::Engine.should_receive(:generate_salt)

    PasswordPolicy.secure_user(user, 'clear password')
  end

  it 'should save the generated salt for the user' do
    user.should_receive(:password_salt).and_return(nil)
    BCrypt::Engine.should_receive(:generate_salt).and_return('generated salt')
    user.should_receive(:password_salt=).with('generated salt')

    PasswordPolicy.secure_user(user, 'clear password')
  end

  it 'should use the user''s salt when securing a user' do
    BCrypt::Engine.should_not_receive(:generate_salt)

    PasswordPolicy.secure_user(user, 'clear password')
  end

  it 'should encrypt the password using the determined salt' do
    BCrypt::Engine.should_receive(:hash_secret).with('clear password', 'salt')

    PasswordPolicy.secure_user(user, 'clear password')
  end

  it 'should save the generated password for the user' do
    user.should_receive(:password_hash=).with('password')

    PasswordPolicy.secure_user(user, 'clear password')
  end

  it 'should return true if the clear password matches the user''s hashed password' do
    user.should_receive(:password_hash).and_return('password')
    BCrypt::Engine.should_receive(:hash_secret).with('clear password', 'salt').and_return('password')

    expect(PasswordPolicy.passwords_match?(user, 'clear password')).to be_true
  end
end