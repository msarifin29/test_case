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
BASE_URL='https://xszdqsccsqfpnyhypoxu.supabase.co';
API_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhzemRxc2Njc3FmcG55aHlwb3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc2MzQ3NzAsImV4cCI6MjAzMzIxMDc3MH0.BWAcDCg4JffpSh4N_Ybyc7PD9p8q8d1m8vjsqGO8CKM';
```
3. Update your pupspec.yaml file by following this code
```
assets:
    - .env
```
4. Run `flutter pub get`
