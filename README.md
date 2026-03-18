# peasy-compress

[![Gem Version](https://badge.fury.io/rb/peasy-compress.svg)](https://rubygems.org/gems/peasy-compress)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://agentgif.com/badge/github/peasytools/peasy-compress-rb/stars.svg)](https://github.com/peasytools/peasy-compress-rb)

Ruby client for the [Peasy Compress](https://peasytools.com) API -- compress, archive, and extract files with ZIP, TAR, gzip, Brotli, and Zstandard. Zero dependencies beyond Ruby stdlib (Net::HTTP, JSON, URI).

Built from [Peasy Tools](https://peasytools.com), a comprehensive file compression toolkit offering free online tools for creating and extracting archives across multiple formats. The glossary covers compression algorithms from classic DEFLATE to modern Brotli and Zstandard, while guides compare archive formats and explain lossless vs lossy compression strategies.

> **Explore compression formats at [peasytools.com](https://peasytools.com)** -- [ZIP](https://peasytools.com/formats/zip/), [TAR](https://peasytools.com/formats/tar/), [Gzip](https://peasytools.com/formats/gz/), and more.

<p align="center">
  <a href="https://agentgif.com/TxI0mdN1"><img src="https://media.agentgif.com/TxI0mdN1.gif" alt="peasy-compress demo -- ZIP, TAR, and gzip compression tools in Ruby terminal" width="800"></a>
</p>

## Table of Contents

- [Install](#install)
- [Quick Start](#quick-start)
- [What You Can Do](#what-you-can-do)
  - [Compression and Archive Tools](#compression-and-archive-tools)
  - [Browse Compression Reference Content](#browse-compression-reference-content)
  - [Search and Discovery](#search-and-discovery)
- [API Client](#api-client)
  - [Available Methods](#available-methods)
- [Learn More About Compression](#learn-more-about-compression)
- [Also Available](#also-available)
- [Peasy Developer Tools](#peasy-developer-tools)
- [License](#license)

## Install

```bash
gem install peasy-compress
```

Or add to your Gemfile:

```ruby
gem "peasy-compress"
```

## Quick Start

```ruby
require "peasy_compress"

client = PeasyCompress::Client.new

# List available compression tools
tools = client.list_tools
tools["results"].each do |tool|
  puts "#{tool["name"]}: #{tool["description"]}"
end
```

## What You Can Do

### Compression and Archive Tools

File compression reduces storage costs and speeds up network transfers. Archive formats like ZIP and TAR bundle multiple files into a single container, while compression algorithms like DEFLATE, Brotli, and Zstandard reduce the size of the archived data. Understanding which format to use -- ZIP for cross-platform compatibility, TAR+gzip for Unix workflows, or Brotli for web content delivery -- is critical for choosing the right tool for each task.

| Format | Type | Best For |
|--------|------|----------|
| ZIP | Archive + Compression | Cross-platform file sharing, per-file compression |
| TAR | Archive only | Unix/Linux bundles, combined with gzip or Brotli |
| gzip | Compression only | Single file compression, HTTP content encoding |
| Brotli | Compression only | Web assets, higher compression ratios than gzip |
| Zstandard | Compression only | Fast real-time compression, database backups |

```ruby
require "peasy_compress"

client = PeasyCompress::Client.new

# Fetch the ZIP compression tool details
tool = client.get_tool("zip-compress")
puts "Tool: #{tool["name"]}"           # ZIP compression tool
puts "Category: #{tool["category"]}"   # Archive and compression category

# List supported compression and archive formats
formats = client.list_formats
formats["results"].each do |fmt|
  puts "#{fmt["name"]} (#{fmt["extension"]}): #{fmt["mime_type"]}"
end
```

Learn more: [ZIP Format Reference](https://peasytools.com/formats/zip/) · [TAR Format Reference](https://peasytools.com/formats/tar/) · [Archive Formats Compared](https://peasytools.com/guides/archive-formats-compared/)

### Browse Compression Reference Content

The compression glossary explains key concepts from basic archiving terminology to advanced algorithm details. Understanding the difference between lossless and lossy compression, how DEFLATE works under the hood, and when to choose Brotli over gzip helps developers make informed decisions about their compression pipelines.

| Glossary Term | Description |
|---------------|-------------|
| Archive | A single file containing multiple files and directory structures |
| TAR | Tape Archive format that bundles files without compression |
| Brotli | Google-developed compression algorithm optimized for web content |
| Lossless Compression | Compression that preserves all original data upon decompression |
| Zstandard | Facebook-developed algorithm balancing speed and compression ratio |

```ruby
# Browse compression glossary terms programmatically
glossary = client.list_glossary(search: "gzip")
glossary["results"].each do |term|
  puts "#{term["term"]}: #{term["definition"]}" # Compression algorithm definition
end

# Read in-depth guides comparing archive formats
guides = client.list_guides(category: "compression")
guides["results"].each do |guide|
  puts "#{guide["title"]} (#{guide["audience_level"]})" # Guide title and difficulty
end
```

Learn more: [Archive Glossary](https://peasytools.com/glossary/archive/) · [Brotli Glossary](https://peasytools.com/glossary/brotli/) · [Lossless vs Lossy Compression Guide](https://peasytools.com/guides/lossless-vs-lossy-compression-guide/)

### Search and Discovery

The unified search endpoint queries across all compression tools, glossary terms, guides, and supported file formats simultaneously. This is useful for building scripts, documentation search, or automation that needs to find the right compression approach.

```ruby
# Search across all compression tools, glossary, and guides
results = client.search("zip")
puts "Found #{results["results"]["tools"].length} tools"
puts "Found #{results["results"]["glossary"].length} glossary terms"
```

Learn more: [TAR Glossary](https://peasytools.com/glossary/tar/) · [Lossless Compression Glossary](https://peasytools.com/glossary/lossless-compression/) · [Zstandard Glossary](https://peasytools.com/glossary/zstandard/)

## API Client

The client wraps the [Peasy Tools REST API](https://peasytools.com/developers/) using only Ruby standard library -- no external dependencies.

```ruby
require "peasy_compress"

client = PeasyCompress::Client.new
# Or with a custom base URL:
# client = PeasyCompress::Client.new(base_url: "https://custom.example.com")

# List tools with pagination and filters
tools = client.list_tools(page: 1, limit: 10, search: "zip")

# Get a specific tool by slug
tool = client.get_tool("zip-compress")
puts "#{tool["name"]}: #{tool["description"]}"

# Search across all content
results = client.search("zip")
puts "Found #{results["results"]["tools"].length} tools"

# Browse the glossary
glossary = client.list_glossary(search: "gzip")
glossary["results"].each do |term|
  puts "#{term["term"]}: #{term["definition"]}"
end

# Discover guides
guides = client.list_guides(category: "compression")
guides["results"].each do |guide|
  puts "#{guide["title"]} (#{guide["audience_level"]})"
end

# List file format conversions
conversions = client.list_conversions(source: "zip")

# Get format details
format = client.get_format("zip")
puts "#{format["name"]} (#{format["extension"]}): #{format["mime_type"]}"
```

### Available Methods

| Method | Description |
|--------|-------------|
| `list_tools` | List tools (paginated, filterable) |
| `get_tool(slug)` | Get tool by slug |
| `list_categories` | List tool categories |
| `list_formats` | List file formats |
| `get_format(slug)` | Get format by slug |
| `list_conversions` | List format conversions |
| `list_glossary` | List glossary terms |
| `get_glossary_term(slug)` | Get glossary term |
| `list_guides` | List guides |
| `get_guide(slug)` | Get guide by slug |
| `list_use_cases` | List use cases |
| `search(query)` | Search across all content |
| `list_sites` | List Peasy sites |
| `openapi_spec` | Get OpenAPI specification |

All list methods accept keyword arguments: `page:`, `limit:`, `category:`, `search:`.

Full API documentation at [peasytools.com/developers/](https://peasytools.com/developers/).
OpenAPI 3.1.0 spec: [peasytools.com/api/openapi.json](https://peasytools.com/api/openapi.json).

## Learn More About Compression

- **Formats**: [ZIP](https://peasytools.com/formats/zip/) · [TAR](https://peasytools.com/formats/tar/) · [Gzip](https://peasytools.com/formats/gz/) · [All Formats](https://peasytools.com/formats/)
- **Guides**: [Archive Formats Compared](https://peasytools.com/guides/archive-formats-compared/) · [Lossless vs Lossy Compression](https://peasytools.com/guides/lossless-vs-lossy-compression-guide/) · [All Guides](https://peasytools.com/guides/)
- **Glossary**: [Archive](https://peasytools.com/glossary/archive/) · [TAR](https://peasytools.com/glossary/tar/) · [Brotli](https://peasytools.com/glossary/brotli/) · [Lossless Compression](https://peasytools.com/glossary/lossless-compression/) · [Zstandard](https://peasytools.com/glossary/zstandard/) · [All Terms](https://peasytools.com/glossary/)
- **API**: [REST API Docs](https://peasytools.com/developers/) · [OpenAPI Spec](https://peasytools.com/api/openapi.json)

## Also Available

| Language | Package | Install |
|----------|---------|---------|
| **Python** | [peasy-compress](https://pypi.org/project/peasy-compress/) | `pip install "peasy-compress[all]"` |
| **TypeScript** | [peasy-compress](https://www.npmjs.com/package/peasy-compress) | `npm install peasy-compress` |
| **Go** | [peasy-compress-go](https://pkg.go.dev/github.com/peasytools/peasy-compress-go) | `go get github.com/peasytools/peasy-compress-go` |
| **Rust** | [peasy-compress](https://crates.io/crates/peasy-compress) | `cargo add peasy-compress` |

## Peasy Developer Tools

Part of the [Peasy Tools](https://peasytools.com) open-source developer ecosystem.

| Package | PyPI | npm | RubyGems | Description |
|---------|------|-----|----------|-------------|
| peasy-pdf | [PyPI](https://pypi.org/project/peasy-pdf/) | [npm](https://www.npmjs.com/package/peasy-pdf) | [Gem](https://rubygems.org/gems/peasy-pdf) | PDF merge, split, rotate, compress -- [peasypdf.com](https://peasypdf.com) |
| peasy-image | [PyPI](https://pypi.org/project/peasy-image/) | [npm](https://www.npmjs.com/package/peasy-image) | [Gem](https://rubygems.org/gems/peasy-image) | Image resize, crop, convert, compress -- [peasyimage.com](https://peasyimage.com) |
| peasy-audio | [PyPI](https://pypi.org/project/peasy-audio/) | [npm](https://www.npmjs.com/package/peasy-audio) | [Gem](https://rubygems.org/gems/peasy-audio) | Audio trim, merge, convert, normalize -- [peasyaudio.com](https://peasyaudio.com) |
| peasy-video | [PyPI](https://pypi.org/project/peasy-video/) | [npm](https://www.npmjs.com/package/peasy-video) | [Gem](https://rubygems.org/gems/peasy-video) | Video trim, resize, thumbnails, GIF -- [peasyvideo.com](https://peasyvideo.com) |
| peasy-css | [PyPI](https://pypi.org/project/peasy-css/) | [npm](https://www.npmjs.com/package/peasy-css) | [Gem](https://rubygems.org/gems/peasy-css) | CSS minify, format, analyze -- [peasycss.com](https://peasycss.com) |
| **peasy-compress** | [PyPI](https://pypi.org/project/peasy-compress/) | [npm](https://www.npmjs.com/package/peasy-compress) | [Gem](https://rubygems.org/gems/peasy-compress) | **ZIP, TAR, gzip compression -- [peasytools.com](https://peasytools.com)** |
| peasy-document | [PyPI](https://pypi.org/project/peasy-document/) | [npm](https://www.npmjs.com/package/peasy-document) | [Gem](https://rubygems.org/gems/peasy-document) | Markdown, HTML, CSV, JSON conversion -- [peasyformats.com](https://peasyformats.com) |
| peasytext | [PyPI](https://pypi.org/project/peasytext/) | [npm](https://www.npmjs.com/package/peasytext) | [Gem](https://rubygems.org/gems/peasytext) | Text case conversion, slugify, word count -- [peasytext.com](https://peasytext.com) |

## License

MIT
