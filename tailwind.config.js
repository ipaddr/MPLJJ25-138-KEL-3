/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#2BD47D",
        secondary: "#1A1F2B",
        accent: "#F9F871",
        textLight: "#FFFFFF",
        textMuted: "#C5C5C5",
      },
      fontFamily: {
        genz: ["'Poppins'", "sans-serif"],
      },
    },
  },
  plugins: [],
};
