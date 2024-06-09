# test_case

Required Flutter 3.16 or higher

This App using supabase for backend

You can replace with your supabase by follwing this stepe :

1. Create New Account or Sign In https://supabase.com/
2. Create New Project
3. In your Dashboard click Database and Add New Table
4. Edit Name table to `todos` to create new Table with name todos
5. Disable checkbox `Enable Row Level Security (RLS)`
6. Click Add Column , edit Name with `title` to create new column with name title,
   select Type to text and set as empty string
7. Click Add Column , edit Name with `description` to create new column with name description,
   select Type to text and set as empty string
8. Save

## Notes 
Replace `BASE_URL` and `API_KEY` with your supabase in Dashboard

### How to Run 

1. Create new file .env in the root project
2. Copy BASE_URL AND API_KEY in your `.env` file
```
BASE_URL=[see on google drive];
API_KEY=[see on google drive];
```
3. Update your pupspec.yaml file by following this code
```
assets:
    - .env
```
4. Run `flutter pub get`
