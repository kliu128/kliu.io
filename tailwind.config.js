/** @type {import('tailwindcss').Config} */
module.exports = {
  prefix: 't-',
  corePlugins: {
    preflight: false
  },
  content: [
    './_includes/**/*.html',
    './_layouts/**/*.html',
    './_posts/*.md',
    './*.html',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
