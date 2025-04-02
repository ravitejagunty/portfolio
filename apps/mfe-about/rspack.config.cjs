const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
// const ReactRefreshPlugin = require('@rspack/plugin-react-refresh');
const { rspack } = require('@rspack/core');

module.exports = {
  entry: './src/main.tsx',
  mode: 'development',
  output: {
    publicPath: 'auto',
    clean: true,
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  devServer: {
    port: 3004,
    open: false,
    historyApiFallback: true,
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        loader: 'builtin:swc-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.css$/i,
        use: ['style-loader', 'css-loader', 'postcss-loader'],
      },
    ],
  },
  plugins: [
    new rspack.container.ModuleFederationPlugin({
      name: 'mfe_about',
      filename: 'remoteEntry.js',
      exposes: {
        './AboutApp': './src/AboutApp',
      },
      shared: {
        react: { singleton: true },
        'react-dom': { singleton: true },
      },
    }),
    new HtmlWebpackPlugin({
      template: './public/index.html',
    }),
  ],
};