user = User.find_by email: ARGV[0]
if user != nil
  user.is_admin = true
  user.save
  puts user.name + '이(가) 관리자로 설정되었습니다'
else
  puts '존재하지 않는 사람입니다'
end
