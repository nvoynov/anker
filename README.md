# Anker

Anker is CSV notes generator for Anki. It provides simple format for designing a set of notes in plain text files, parser of the format, and CSV generator.

"Basic", "Cloze", and "Basic and optionally Reversible" notes could be written in the same single file and then transformed into a set of CSV files - one file per note type.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add anker

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install anker

## Usage

### Note format

Set of lines divided by new string will be parsed as single note. Each separate line will be presented as `<p>line</p>`. The first line will serve as note's "face" and all following lines will be packed in the note's "back".

Assuming one wrote the following note source

```
face
back
- item 1
- item 2
```

This note will be presented as

Front

```html
<p>face</p>
```

Back

```html
<p>back</p><ul> <li>item 1</li> <li>item 2</li> </ul>
```

Inclusion of `{{..}}` in the first "face" line will tell the Anker that the note is "Cloze". Finishing a note with `y` or `n` will tell the Anker that the note is "Basic optionally Reversible."

When you need more than one line for "face", you can use `|` as line separator.

```
negligence | /ˈneɡlɪdʒəns/ | noun
the failure to give sb./sth. enough care or attention
- The doctor was sued for medical negligence.
```

The note above will produce

Front

```html
<p>negligence</br>/ˈneɡlɪdʒəns/</br>noun</p>
```

Back

```html
<p>the failure to give sb./sth. enough care or attention</p> <ul><li>The doctor was sued for medical negligence.</li></ul>
```

### File format

Suppose you have the following source file `sample.anki`

```
% notes subject

# Basic
face
back

# Basic and optionally Reversible
face
back 1
back 2
y

# Cloze
cloze {{c1::cloze::clozed}}
back
```

Running `$ anker sample.anki` command will parse the source file and create three csv files - `sample.basic.csv`, `sample.rever.csv`, and `sample.cloze.csv`.

Lines started from `%` or `#` will be ignored.

Having resulting csv you can import those into your Anki app.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/anker.
