use 5.010;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'PDL::IO::GGUF',
    AUTHOR             => q{C.J. Collier <cjac@google.com>},
    VERSION_FROM       => 'lib/PDL/IO/GGUF.pm',
    ABSTRACT_FROM      => 'lib/PDL/IO/GGUF.pm',
    LICENSE            => 'perl_5',
    MIN_PERL_VERSION   => '5.010',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    TEST_REQUIRES => {
        'Test::More' => '0.88',
        'File::Temp' => '0',
    },
    PREREQ_PM => {
        'PDL'  => '2.080',
        'Carp' => '0',
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {
            repository => {
                type => 'git',
                url  => 'https://github.com/PDLPorters/PDL-IO-GGUF.git',
                web  => 'https://github.com/PDLPorters/PDL-IO-GGUF',
            },
            bugtracker => {
                web => 'https://github.com/PDLPorters/PDL-IO-GGUF/issues',
            },
        },
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'PDL-IO-GGUF-*' },
);
