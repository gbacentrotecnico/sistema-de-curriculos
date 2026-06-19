import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://hlnrudinejjaggejpsrc.supabase.co';
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhsbnJ1ZGluZWpqYWdnZWpwc3JjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE4NzMwMTIsImV4cCI6MjA5NzQ0OTAxMn0.JIUBtnCPspUQiIBHAEFgpL9b_iQf4ByIorUUWMfs1sw';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
