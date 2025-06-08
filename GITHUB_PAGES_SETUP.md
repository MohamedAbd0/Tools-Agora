# GitHub Pages Deployment Guide

This guide explains how to deploy the Agora Token Generator Flutter web example to GitHub Pages automatically using GitHub Actions.

## 🚀 Live Demo

The live demo is available at: **[https://yourusername.github.io/Tools-Agora/](https://yourusername.github.io/Tools-Agora/)**

> Replace `yourusername` with your actual GitHub username

## 📋 Prerequisites

1. **GitHub Repository** - Your repository should be public or you have GitHub Pro/Team for private repos
2. **Flutter Web App** - The example app is located in `DynamicKey/AgoraDynamicKey/dart/example/`
3. **GitHub Actions** - Must be enabled for your repository

## ⚙️ Setup Instructions

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click on **Settings** tab
3. Scroll down to **Pages** section in the left sidebar
4. Under **Source**, select **GitHub Actions**
5. Click **Save**

### Step 2: Configure Repository Permissions

1. Go to **Settings** > **Actions** > **General**
2. Under **Workflow permissions**, select:
   - ✅ **Read and write permissions**
   - ✅ **Allow GitHub Actions to create and approve pull requests**
3. Click **Save**

### Step 3: Update Base URL (if needed)

If your repository name is different from `Tools-Agora`, update the workflow file:

```yaml
# In .github/workflows/deploy-flutter-web.yml
# Change this line:
--base-href "/Tools-Agora/" \
# To:
--base-href "/YOUR-REPO-NAME/" \
```

### Step 4: Push Changes

The deployment will trigger automatically when you push changes to the `main` or `master` branch that affect files in the `DynamicKey/AgoraDynamicKey/dart/example/` directory.

```bash
git add .
git commit -m "Setup GitHub Pages deployment for Flutter web demo"
git push origin main
```

## 🔄 Automatic Deployment

The GitHub Actions workflow will:

1. **Trigger on**:
   - Push to `main`/`master` branch
   - Changes in `DynamicKey/AgoraDynamicKey/dart/example/**`
   - Manual workflow dispatch

2. **Build Process**:
   - Setup Flutter SDK (v3.24.0)
   - Enable Flutter web support
   - Install dependencies for both main package and example
   - Build web app with optimizations
   - Deploy to GitHub Pages

3. **Deployment**:
   - Artifacts uploaded to GitHub Pages
   - Site available at `https://USERNAME.github.io/REPO-NAME/`

## 📁 File Structure

```
Tools-Agora/
├── .github/
│   └── workflows/
│       └── deploy-flutter-web.yml    # GitHub Actions workflow
├── DynamicKey/
│   └── AgoraDynamicKey/
│       └── dart/
│           ├── example/              # Flutter web app source
│           │   ├── lib/
│           │   ├── web/
│           │   │   ├── index.html    # Updated with GitHub Pages config
│           │   │   └── manifest.json # Updated with app metadata
│           │   └── pubspec.yaml
│           └── pubspec.yaml          # Main package
└── GITHUB_PAGES_SETUP.md            # This file
```

## 🛠️ Configuration Details

### Workflow Configuration

```yaml
# .github/workflows/deploy-flutter-web.yml
name: Deploy Flutter Web to GitHub Pages

on:
  push:
    branches: [ main, master ]
    paths: 
      - 'DynamicKey/AgoraDynamicKey/dart/example/**'
  workflow_dispatch:

# Build and deploy steps...
```

### Build Settings

The app is built with these optimizations:
- **Release mode** for performance
- **HTML renderer** for better compatibility
- **Base href** set for GitHub Pages subdirectory
- **Skia disabled** for faster loading

### Web Configuration

**index.html** includes:
- SEO-optimized meta tags
- Open Graph and Twitter Card support
- Loading screen with branding
- Responsive design support

**manifest.json** configured for:
- Progressive Web App (PWA) support
- Agora branding and colors
- Proper app metadata

## 🔍 Monitoring Deployment

1. **Actions Tab**: Monitor build progress in GitHub Actions
2. **Environment**: Check deployment status in repository environments
3. **Pages Settings**: View deployment history and URLs

### Checking Build Status

Visit: `https://github.com/USERNAME/REPO-NAME/actions`

Look for the "Deploy Flutter Web to GitHub Pages" workflow.

## 🐛 Troubleshooting

### Common Issues

1. **Build Fails**
   - Check Flutter dependencies in both `dart/` and `dart/example/`
   - Ensure all required packages are properly configured
   - Verify Flutter SDK version compatibility

2. **404 Error on Page Load**
   - Verify base href matches your repository name
   - Check if GitHub Pages is enabled
   - Ensure the workflow completed successfully

3. **Assets Not Loading**
   - Confirm base href is correctly set
   - Check if all assets are in the `web/` directory
   - Verify build artifacts were uploaded correctly

### Manual Deployment

If automatic deployment fails, you can trigger it manually:

1. Go to **Actions** tab
2. Select "Deploy Flutter Web to GitHub Pages"
3. Click **Run workflow**
4. Choose branch and click **Run workflow**

## 🎯 Customization

### Custom Domain

To use a custom domain:

1. Add a `CNAME` file to `web/` directory:
   ```
   your-domain.com
   ```

2. Configure DNS to point to `USERNAME.github.io`

3. Enable custom domain in repository settings

### Environment Variables

Add build-time environment variables in the workflow:

```yaml
- name: Build web app
  working-directory: ./DynamicKey/AgoraDynamicKey/dart/example
  run: |
    flutter build web \
      --release \
      --dart-define=API_URL=https://api.example.com \
      --dart-define=ENV=production
```

## 📊 Performance Optimization

The deployment includes several optimizations:

- **Tree shaking** - Removes unused code
- **Minification** - Reduces file sizes
- **HTML renderer** - Better performance on web
- **Static asset caching** - Improves load times

## 🔐 Security Considerations

- **No sensitive data** in client-side code
- **HTTPS enforcement** via GitHub Pages
- **Content Security Policy** can be added to index.html
- **Environment separation** between development and production

## 📈 Analytics & Monitoring

To add analytics:

1. **Google Analytics**:
   ```html
   <!-- Add to web/index.html -->
   <script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
   ```

2. **GitHub Pages insights** available in repository settings

## 🤝 Contributing

To contribute to the deployment setup:

1. Fork the repository
2. Make changes to workflow or configuration
3. Test deployment on your fork
4. Submit pull request with improvements

---

## 📞 Support

- **GitHub Issues**: Report deployment issues
- **Flutter Docs**: [flutter.dev/docs/deployment/web](https://flutter.dev/docs/deployment/web)
- **GitHub Pages Docs**: [docs.github.com/pages](https://docs.github.com/pages)

---

**Last Updated**: June 2025  
**Deployment**: Automatic via GitHub Actions  
**Status**: ✅ Active
