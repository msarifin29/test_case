# test_case

Required Flutter 3.16 or higher

This App using supabase for backend

### How to Run 

1. Create new file .env in the root project
2. Copy BASE_URL AND API_KEY inside file .env
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