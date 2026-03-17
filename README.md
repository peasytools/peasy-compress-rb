# peasy-compress

[![Gem Version](https://badge.fury.io/rb/peasy-compress.svg)](https://rubygems.org/gems/peasy-compress)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Ruby client for the [Peasy Compress](https://peasytools.com) API — ZIP, TAR, and gzip compression tools. Zero dependencies beyond Ruby stdlib (Net::HTTP, JSON, URI).

Built from [Peasy Tools](https://peasytools.com), a free online developer toolkit with compression utilities for creating archives, extracting files, and optimizing file sizes across ZIP, TAR, gzip, and other formats.

> **Try the interactive tools at [peasytools.com](https://peasytools.com)** — [Compression Tools](https://peasytools.com/), [Glossary](https://peasytools.com/glossary/), [Guides](https://peasytools.com/guides/)

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

## API Client

The client wraps the [Peasy Tools REST API](https://peasytools.com/developers/) using only Ruby standard library — no external dependencies.

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

## Learn More

- **Tools**: [ZIP Compress](https://peasytools.com/tools/zip-compress/) · [TAR Archive](https://peasytools.com/tools/tar-archive/) · [All Tools](https://peasytools.com/)
- **Guides**: [How to Compress Files](https://peasytools.com/guides/how-to-compress-files/) · [All Guides](https://peasytools.com/guides/)
- **Glossary**: [What is Gzip?](https://peasytools.com/glossary/gzip/) · [All Terms](https://peasytools.com/glossary/)
- **Formats**: [ZIP](https://peasytools.com/formats/zip/) · [All Formats](https://peasytools.com/formats/)
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
| peasy-pdf | [PyPI](https://pypi.org/project/peasy-pdf/) | [npm](https://www.npmjs.com/package/peasy-pdf) | [Gem](https://rubygems.org/gems/peasy-pdf) | PDF merge, split, rotate, compress — [peasypdf.com](https://peasypdf.com) |
| peasy-image | [PyPI](https://pypi.org/project/peasy-image/) | [npm](https://www.npmjs.com/package/peasy-image) | [Gem](https://rubygems.org/gems/peasy-image) | Image resize, crop, convert, compress — [peasyimage.com](https://peasyimage.com) |
| peasy-audio | [PyPI](https://pypi.org/project/peasy-audio/) | [npm](https://www.npmjs.com/package/peasy-audio) | [Gem](https://rubygems.org/gems/peasy-audio) | Audio trim, merge, convert, normalize — [peasyaudio.com](https://peasyaudio.com) |
| peasy-video | [PyPI](https://pypi.org/project/peasy-video/) | [npm](https://www.npmjs.com/package/peasy-video) | [Gem](https://rubygems.org/gems/peasy-video) | Video trim, resize, thumbnails, GIF — [peasyvideo.com](https://peasyvideo.com) |
| peasy-css | [PyPI](https://pypi.org/project/peasy-css/) | [npm](https://www.npmjs.com/package/peasy-css) | [Gem](https://rubygems.org/gems/peasy-css) | CSS minify, format, analyze — [peasycss.com](https://peasycss.com) |
| **peasy-compress** | [PyPI](https://pypi.org/project/peasy-compress/) | [npm](https://www.npmjs.com/package/peasy-compress) | [Gem](https://rubygems.org/gems/peasy-compress) | **ZIP, TAR, gzip compression — [peasytools.com](https://peasytools.com)** |
| peasy-document | [PyPI](https://pypi.org/project/peasy-document/) | [npm](https://www.npmjs.com/package/peasy-document) | [Gem](https://rubygems.org/gems/peasy-document) | Markdown, HTML, CSV, JSON conversion — [peasyformats.com](https://peasyformats.com) |
| peasytext | [PyPI](https://pypi.org/project/peasytext/) | [npm](https://www.npmjs.com/package/peasytext) | [Gem](https://rubygems.org/gems/peasytext) | Text case conversion, slugify, word count — [peasytext.com](https://peasytext.com) |

## License

MIT
