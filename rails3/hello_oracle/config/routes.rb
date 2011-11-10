HelloOracle::Application.routes.draw do
  match 'db/init'
  match 'db/query'
  match 'db/update'
  match 'db/create'
  match 'db/delete'
  match 'db/sp_create'
  match 'db/sp_authored_books'
 end
